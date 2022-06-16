<p align="center">
    <img width="100" src="https://user-images.githubusercontent.com/1866496/173375782-cf5bcb4e-8e7d-4e0f-984f-fef5202362a0.png"/>
</p>

<h1 align="center">AuctionX Docker images</h1>

> We advise you to use this docker images in a [docker-compose](https://docs.docker.com/compose/) environment, especially for the API one which need other components: 
>  - PostgreSQL >= 13
>  - Webserver (Caddy, NGINX, Apache, etc.)

## Api

### Build & publish

```shell
sh publish-api.sh
```

### Usage

Pull container:

```shell
docker pull ghcr.io/getaux/api:latest
```

Run api:

```shell
docker run --name auctionx-api \
 --env APP_ENV=prod \
 --env DATABASE_URL="postgresql://user:password@127.0.0.1:5432/database_name?serverVersion=13&charset=utf8" \
 --env SERVER_NAME=api.yourdomain.tld \
 --env IMX_API_ENV=prod \
 --env IMX_ESCROW_WALLET=public_key_of_your_escrow_wallet \
 --env BUS_API_KEY=api_key_for_you_worker \
 -it ghcr.io/getaux/api;
```

Create database on your postgresql:
```shell
docker exec -it auctionx-api console doctrine:database:create
```

Create database schema:

```shell
docker exec -it auctionx-api console doctrine:migrations:migrate
```

## Worker

### Build & publish

```shell
sh publish-worker.sh
```

### Usage

Pull container:

```shell
docker pull ghcr.io/getaux/worker:latest
```

Setup worker and setup credentials:

```shell
docker run --name auctionx-worker -v ~/.auctionx:/srv/app/.auctionx -it ghcr.io/getaux/worker
```

Run worker with auto-restart to process messages:

```shell
docker run --name auctionx-worker -d --restart unless-stopped -v ~/.auctionx:/srv/app/.auctionx ghcr.io/getaux/worker
```

## License

Licensed under the terms of the MIT License.