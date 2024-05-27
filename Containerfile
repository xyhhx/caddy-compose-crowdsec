 FROM caddy:2.7.6-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@main

FROM chainguard/caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
