# nzbget-alpine

Always shipped with the latest testing nzbget version! Providing a path to your own config is optional.

Quick start:
```shell
docker run -d -p 6789:6789 -v /path/to/downloads:/downloads --name nzbget helbgd/nzbget-alpine-docker
```

With your own config (make sure to adjust the paths and your logging preferences inside your config file):
```shell
docker run -d -p 6789:6789 -v /path/to/config:/config -v /path/to/downloads:/downloads --name nzbget helbgd/nzbget-alpine-docker
```

To have the container start when the host boots, add docker's restart policy:
```shell
docker run -d --restart=always -p 6789:6789 -v /path/to/config:/config -v /path/to/downloads:/downloads --name helbgd/nzbget-alpine-docker
```
