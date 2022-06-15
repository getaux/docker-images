FROM php:8.1-cli-alpine

LABEL org.opencontainers.image.source="https://github.com/getaux/docker-images"

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
        gmp-dev; \
    docker-php-ext-install gmp; \
    runDeps="$( \
    		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
    			| tr ',' '\n' \
    			| sort -u \
    			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    	)"; \
    apk add --no-cache --virtual .phpexts-rundeps $runDeps; \
    \
    apk del .build-deps; \
    mkdir -p /srv/app/.auctionx;

ENV HOME="/srv/app"

WORKDIR /srv/app

RUN php -r "copy('https://github.com/getaux/worker/releases/latest/download/auctionx-worker', './auctionx-worker');"; \
    chmod 755 /srv/app/auctionx-worker;

CMD ["/srv/app/auctionx-worker"]