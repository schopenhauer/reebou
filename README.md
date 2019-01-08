# reebou

Gudde Moien &mdash; I am your friendly RSS and Atom news reader written in the Ruby framework [Sinatra](http://www.sinatrarb.com/) and pre-configured to read Luxembourgish (Lëtzebuergesch) newspapers and tabloids.

<img src="https://github.com/schopenhauer/reebou/blob/master/public/screenshot-sm.png">

## Features

- I work out of the box (zero configuration)
- I read RSS, XML and Atom feeds
- I cache to be lightening fast
- I am colorful
- I am made in Luxembourg with :heart:

## Usage

If need be, you customise feed names, URLs and colours in the `feeds.yml` file.

Next step, run the app.

```
bundle install
foreman start
```

The app is ready to be deployed to a cloud service provider (e.g. Heroku, Azure, Google App Engine). The `Procfile` and `app.yaml` files have already been configured with sane defaults.

## Caching

Reebou works with [Memcached](https://memcached.org/) and [Memcachier](https://www.memcachier.com/) out of the box. However, Memcached is disabled by default.

You can activate caching by setting the below environment variables.

| Memcached | Memcachier | Default value | Description |
|-----------|------------|---------------|-------------|
| `MEMCACHED_URL` | `MEMCACHIER_SERVERS` | _to be set_ | Memcached server or socket |
| `MEMCACHED_USERNAME` | `MEMCACHIER_USERNAME` | _to be set_ | Memcached username |
| `MEMCACHED_PASSWORD` | `MEMCACHIER_PASSWORD` | _to be set_ | Memcached password |
| `MEMCACHED_TTL` | _same_  | `86400` seconds (24 hours) | Memcached expiry time |
| `MEMCACHED_COMPRESS` | _same_ | `true` | Memcached compression |
| `CACHE_TIME` | _same_ | `900` (15 minutes) | Minimum cache period |
| `CACHE_EXPIRY` | _same_ | `86400` (24 hours) | Maximum cache expiry |
| `CACHE_FREQUENCY` | _same_ | `300` (5 minutes) | Maximum query frequency (`0` = unlimited) |
| `CACHE_TIMEOUT` | _same_ | `30` (30 seconds) | Maximum timeout |

Below some essential commands to install, start and use a [Memcached](https://memcached.org/) server on [Arch Linux](https://www.archlinux.org/packages/extra/x86_64/memcached/).

```sh
sudo pacman -S memcached netcat
sudo systemctl start memcached
netstat -tap | grep memcached
echo 'stats settings' | nc localhost 11211
echo 'flush_all' | nc localhost 11211
```

## Known issues

- [100komma7](https://www.100komma7.lu) does not provide a standardized news feed. The app uses the podcast feed instead.
- The `MEMCACHED_SOCKET` environment variable is not picked up automatically. When you run Memcached locally, you can set `MEMCACHED_URL` to `127.0.0.1:11211` or `unix:/path/to/memcached.sock`.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

- [Sinatra framework](http://www.sinatrarb.com/)
- [Foundation framework](http://foundation.zurb.com/)
- [Google Fonts](https://fonts.google.com/)
- [Feedjira](http://feedjira.com/)
- [Memcached](https://memcached.org/)
- [Puma](http://puma.io/)

## License

The app is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
