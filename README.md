# labo-container-dockerfile

Dockerfile for labo container

```bash
docker run -it --rm \
  --name getto-labo \
  -e DOCKER_WRAPPER_VOLUMES=/docker-volumes/apps:/apps,/docker-volumes/home:/home \
  -e LABO_IP=$ip \
  -e LABO_USER=$user \
  -e LABO_TIMEZONE=$timezone \
  -v /docker-volumes/apps:/apps \
  -v /docker-volumes/home:/home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  getto/labo-container:latest
```


###### Table of Contents

- [Requirements](#Requirements)
- [Usage](#Usage)
- [License](#License)

<a id="Requirements"></a>
## Requirements

- Docker version 18.09.7, build 2d0083d657


<a id="Usage"></a>
## Usage

run labo container with options

```bash
docker run -it --rm \
  --name getto-labo \
  -e DOCKER_WRAPPER_VOLUMES=/docker-volumes/apps:/apps,/docker-volumes/home:/home \
  -e LABO_IP=$ip \
  -e LABO_USER=$user \
  -e LABO_TIMEZONE=$timezone \
  -v /docker-volumes/apps:/apps \
  -v /docker-volumes/home:/home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  getto/labo-container:latest
```


<a id="License"></a>
## License

labo-container-dockerfile is licensed under the [MIT](LICENSE) license.

Copyright &copy; since 2018 shun@getto.system

