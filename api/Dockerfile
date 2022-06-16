FROM php:8.1-fpm-alpine

LABEL org.opencontainers.image.source="https://github.com/getaux/docker-images"

RUN set -eux; \
    apk add --no-cache git; \
    apk add --no-cache --virtual .build-deps \
      libzip-dev \
      gmp-dev \
      libpq-dev; \
    docker-php-ext-configure zip; \
    docker-php-ext-install -j$(nproc) \
      gmp \
      pgsql; \
    runDeps="$( \
    		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
    			| tr ',' '\n' \
    			| sort -u \
    			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    	)"; \
    apk add --no-cache --virtual .phpexts-rundeps $runDeps; \
    apk del .build-deps;

RUN apk add --no-cache --virtual .pgsql-deps postgresql-dev; \
    docker-php-ext-install -j$(nproc) pdo_pgsql; \
    apk add --no-cache --virtual .pgsql-rundeps so:libpq.so.5; \
    apk del .pgsql-deps;

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /srv/api

RUN git clone https://github.com/getaux/api.git /srv/api; \
    composer install; \
    ln -s /srv/api/bin/console /bin/console;

CMD ["php-fpm"]