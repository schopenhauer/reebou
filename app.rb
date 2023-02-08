require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/reloader' if development?
require 'better_errors'
require 'feedjira'
require 'api_cache'
require 'dalli'
require 'htmlentities'
require 'nokogiri'
require 'rufus-scheduler'
require 'dotenv'
Dotenv.load

set :public_folder, 'public'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

configure do
  APP_TITLE = "What's up, Lëtzebuerg?"
  DATETIME_FORMAT = '%B %e, %Y at %H:%M'
  URL_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  GOOGLE_ANALYTICS_ID = ENV['GOOGLE_ANALYTICS_ID'] # optional
  AUTO_FETCH = ENV['AUTO_FETCH'] # optional, e.g. 1h

  MEMCACHED_URL = ENV['MEMCACHED_URL'] || ENV['MEMCACHIER_SERVERS']
  MEMCACHED_USERNAME = ENV['MEMCACHED_USERNAME'] || ENV['MEMCACHIER_USERNAME']
  MEMCACHED_PASSWORD = ENV['MEMCACHED_PASSWORD'] || ENV['MEMCACHIER_PASSWORD']
  MEMCACHED_TTL = ENV['MEMCACHED_TTL'] || 604_800

  CACHE_OPTIONS = {
    cache: ENV['CACHE_TIME'] || 3_600,
    valid: ENV['CACHE_VALID'] || 86_400,
    period: ENV['CACHE_PERIOD'] || 600,
    timeout: ENV['CACHE_TIMEOUT'] || 15
  }

  VERBOSE = ENV['VERBOSE'] || false

  config_file 'feeds.yml'
end

get '/robots.txt' do
  status 200
  body "User-agent: *\nDisallow: /"
end

unless AUTO_FETCH.nil?
  scheduler = Rufus::Scheduler.new
  puts "Enable automatic fetch (every #{AUTO_FETCH})" if VERBOSE
  scheduler.every AUTO_FETCH do
    puts 'Automatically fetching feeds' if VERBOSE
    fetch_all
  end
end

get '/' do
  entries = fetch_all
  request_uri = request.env['HTTP_FORWARDED_REQUEST_URI'] || request.env['REQUEST_URI']
  @base_url = remove_trailing_slash(request_uri)
  erb :feeds, locals: {
    feeds: settings.feeds,
    entries: entries
  }
end

get '/*' do
  redirect '/'
end

private

def fetch(url)
  puts "Fetching: #{url}" if VERBOSE
  begin
    client = Dalli::Client.new(
      [ MEMCACHED_URL, 'localhost:11211' ].compact,
      username: MEMCACHED_USERNAME,
      password: MEMCACHED_PASSWORD,
      expires_in: MEMCACHED_TTL,
      compress: true,
      failover: true,
      namespace: 'reebou'
    )
    APICache.store = APICache::DalliStore.new(client)
    feed = APICache.get(url, CACHE_OPTIONS)
  rescue Dalli::RingError
    APICache.store = nil
    feed = APICache.get(url, CACHE_OPTIONS)
  end
  Feedjira.parse(feed).entries
end

def fetch_all
  entries = {}
  settings.feeds.map { |name, feed| entries[name] = fetch(feed['rss']) }
  entries
end

def partial(template, locals = {})
  erb(template, layout: false, locals: locals)
end

def find_url(entry)
  if valid_url? entry.entry_id
    entry.entry_id
  elsif valid_url? entry.url
    entry.url
  elsif valid_url? entry.link
    entry.link
  else
    '/'
  end
end

def valid_url?(url)
  url =~ URL_REGEX
end

def encode(s)
  HTMLEntities.new.encode(s)
end

def clean(s)
  encode(Nokogiri::HTML.parse(s).text.strip)
end

def uppercase(s)
  s.nil? ? '' : s.tr('.', ' ').split(/([ _-])/).map(&:capitalize).join
end

def remove_trailing_slash(s)
  s.gsub(%r{\/$}, '')
end

def remove_anything_after_linebreaks(s)
  %r{(.).*(?=\n)}.match(s)
end

def timestamp(s)
  s.nil? ? 'n.a.' : s.strftime(DATETIME_FORMAT)
end

# Made to measure for 100komma7 podcast feed
def enumerate(s)
  s.strip.split("\n\t").map { |k| "- #{k}\n" }.join
end
