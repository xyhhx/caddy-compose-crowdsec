<div align="center">

# Caddy

[Caddy Website](https://caddyserver.com/) | [Caddy Documentation](https://caddyserver.com/docs)

Canonical source: https://git.sr.ht/~xyhhx/caddy-compose-crowdsec

[Github Mirror](https://github.com/xyhhx/caddy-compose-crowdsec) | [Codeberg Mirror](https://codeberg.org/xyhhx/caddy-compose-crowdsec)

</div>



## Prerequesites

This repo is designed to be used in a Linux working environment with the following dependencies installed:

- [Docker](https://docker.com)
- `make`

## Usage

### Administration

First, generate a crowdsec API key:

```sh
make crowdsec-key
```

Then run the following commands to start the Compose project

```sh
make up
```

You can spin down the project like so:

```sh
make down
```

You can destroy the project with the following command:

> **Important** This will remove the Docker network and wipe `./data/caddy`

```sh
make clean
```

## Examples

### Adding a simple web app

Let's say your app is called `myapp` and you want to expose it via this Caddy project.

Let's also assume `myapp` exposes port 8000 for its web interface.

#### Configuring your app

Other projects should have the following in their Compose files:


```yml
networks:
  webproxy:
    external: true
```

And, for any services you want to handle with caddy, you should name them and add the `webproxy` network to them.

```yml
services:
  myapp:
    container_name: myapp
    networks:
      - webproxy
```

#### Configuring Caddy

You will also need to make changes to the Caddyfile:

```diff
myapp.com {
  route {
    crowdsec
    reverse_proxy myapp:8000
  }
  log {
    output file /var/log/caddy/access.log
  }
}
```

Finally, you can run the following to restart Caddy:

```sh
make down up
# Or...
docker compose up -d --force-recreate
```
## Further Reading

- https://github.com/hslatman/caddy-crowdsec-bouncer
- https://www.crowdsec.net/blog/secure-docker-compose-stacks-with-crowdsec
