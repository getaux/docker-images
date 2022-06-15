<p align="center">
    <img width="100" src="https://user-images.githubusercontent.com/1866496/173375782-cf5bcb4e-8e7d-4e0f-984f-fef5202362a0.png"/>
</p>

<h1 align="center">AuctionX Docker images</h1>

## Worker

### Build & publish

`sh publish-worker.sh`

### Usage

Pull container:

```
docker pull ghcr.io/getaux/worker:latest
```

Setup worker and setup credentials:

```
docker run --name auctionx-worker -v ~/.auctionx:/srv/app/.auctionx -it ghcr.io/getaux/worker
```

Run worker with auto-restart to process messages:

```
docker run --name auctionx-worker -d --restart unless-stopped -v ~/.auctionx:/srv/app/.auctionx ghcr.io/getaux/worker
```

## License

Licensed under the terms of the MIT License.