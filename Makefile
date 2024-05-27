required_secrets:=.env

crowdsec-key:
	echo "CROWDSEC_API_KEY=`tr -dc A-Za-z0-9 </dev/urandom | head -c 32`" >> .env

up: $(required_secrets)
	docker compose up -d --force-recreate

down:
	docker compose down

clean:
	docker compose down \
	&& docker network rm caddy \
	&& rm -rf data/caddy/*
