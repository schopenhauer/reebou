# reebou

Gudde Moien &mdash; I am your friendly RSS and Atom news reader written in [Sinatra](http://www.sinatrarb.com/), a Ruby framework, and pre-configured to read [Luxembourgish](https://en.wikipedia.org/wiki/Luxembourgish) ([Lëtzebuergesch](https://lb.wikipedia.org/wiki/L%C3%ABtzebuergesch)) newspapers and tabloids.

<img src="https://github.com/schopenhauer/reebou/blob/main/public/images/screenshot-sm.png">

## Features

- I work out of the box (zero configuration)
- I read RSS, XML and Atom feeds
- I am respectful and will cache feeds
- I am lightening fast
- I am colorful
- I am made in Luxembourg with :heart:

## Usage

You can add, edit, remove and customise feeds in the `feeds.yml` configuration file.

Once configured, please make sure to install the gems and run the app.

```sh
bundle install
foreman start
```

The app is ready to be deployed to the cloud (e.g. Heroku, Azure, Google App Engine). The `Procfile` and `app.yaml` files have been configured with sane defaults.

## Caching

### Configuration

Reebou works out of the box with [Memcached](https://memcached.org/) and [Memcachier](https://www.memcachier.com/). Memcached is disabled by default, but you can activate it by setting the following environment variables.

| Environment variable | Default value | Description |
|-----------| --------------|-------------|
| `MEMCACHED_URL` or `MEMCACHIER_SERVERS` | _to be set_ | Memcached server or socket |
| `MEMCACHED_USERNAME` or `MEMCACHIER_USERNAME` | _to be set_ | Memcached username |
| `MEMCACHED_PASSWORD` or `MEMCACHIER_PASSWORD` | _to be set_ | Memcached password |
| `MEMCACHED_TTL` | `604800` seconds (1 week) | Memcached expiry time |
| `CACHE_TIME` | `900` (15 minutes) | Minimum cache period |
| `CACHE_EXPIRY` | `86400` (24 hours) | Maximum cache expiry |
| `CACHE_FREQUENCY` | `300` (5 minutes) | Maximum query frequency (`0` = unlimited) |
| `CACHE_TIMEOUT` | `30` (30 seconds) | Maximum timeout |

### Memcached commands

Please see below some basic commands to start and use a [Memcached](https://memcached.org/) server on your machine.

```sh
systemctl start memcached
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

- [Sinatra](http://www.sinatrarb.com/) framework
- [Feedjira](http://feedjira.com/)
- [Puma](http://puma.io/)
- [Memcached](https://memcached.org/)
- [Foundation](http://foundation.zurb.com/) CSS framework
- [Font Awesome](https://fontawesome.com/) CSS framework
- [Google Fonts](https://fonts.google.com/)

## License

The app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
