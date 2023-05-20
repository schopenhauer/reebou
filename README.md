# reebou

Gudde Moien!

I am your friendly RSS and Atom news reader written in [Sinatra](http://www.sinatrarb.com/), the Ruby framework, and pre-configured to fetch and read [Luxembourgish](https://en.wikipedia.org/wiki/Luxembourgish) ([Lëtzebuergesch](https://lb.wikipedia.org/wiki/L%C3%ABtzebuergesch)) newspapers and tabloids.

<img src="https://github.com/schopenhauer/reebou/blob/main/public/images/screenshot-sm.png">

## Features

- I work out of the box
- I can read RSS, XML and Atom feeds
- I am respectful and cache feeds
- I am lightening fast
- I am colourful
- I am made in Luxembourg with love :heart:

## Usage

You can add, edit, remove and customise feeds in the `feeds.yml` configuration file. Once configured, please make sure to install the gems and run the app.

```sh
bundle install
foreman start
```

`Procfile` and `app.yaml` are configured with sane defaults. The app is ready to be deployed to the cloud.

## Caching

### Configuration

Reebou works out of the box with [Memcached](https://memcached.org/) and [Memcachier](https://www.memcachier.com/). Memcached is disabled by default, but you can activate it by setting the following environment variables.

| Environment variable | Default value | Description |
|-----------| --------------|-------------|
| `MEMCACHED_URL` or `MEMCACHIER_SERVERS` | _to be set_ | Memcached server or socket |
| `MEMCACHED_USERNAME` or `MEMCACHIER_USERNAME` | _to be set_ | Memcached username |
| `MEMCACHED_PASSWORD` or `MEMCACHIER_PASSWORD` | _to be set_ | Memcached password |
| `MEMCACHED_TTL` | `604800` (7 days) | Memcached expiry time |
| `CACHE_TIME` | `3600` (1 hour) | After this time fetch new data |
| `CACHE_VALID` | `86400` (1 day) | Maximum time to use old data<br>(e.g `0` = forever) |
| `CACHE_PERIOD` | `600` (10 minutes) | Maximum query frequency<br>(e.g. `0` = unlimited) |
| `CACHE_TIMEOUT` | `15` (15 seconds) | HTTP response timeout |
| `AUTO_FETCH` | _optional_ | Automatic feed fetching<br>(e.g. `1h` = every hour) |

### Helpful commands (memcached)

Below some help commands to start and use a [memcached](https://memcached.org/) instance on your machine.

```sh
sudo systemctl start memcached
netstat -tap | grep memcached
echo 'stats settings' | nc localhost 11211
echo 'flush_all' | nc localhost 11211
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

- [Sinatra](http://www.sinatrarb.com) framework
- [Feedjira](http://feedjira.com)
- [Puma](http://puma.io)
- [Memcached](https://memcached.org)
- [Foundation](http://foundation.zurb.com) CSS framework
- [Font Awesome](https://fontawesome.com) CSS framework
- [Google Fonts](https://fonts.google.com)

## License

The app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
