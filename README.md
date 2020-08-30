# Bioconductor Docker with MEME Suite

Builds the bioconductor docker container with the [meme-suite](meme-suite.org) v5.1.1, using python3.7.1

**NOTE:** Currently only builds from the `bioconductor_docker:devel` container. In the future, I will support stable releases.

## Docker

Build the Docker image from Dockerfile:

```
docker build -t snystrom/bioconductor_docker_meme
```

Pull from Dockerhub:

```
docker pull snystrom/bioconductor_docker_meme:devel
```

To run the container:

```
docker run -e PASSWORD=<password> -p 8787:8787 -v <drive/to/mount>:/mnt/<location> snystrom/bioconductor_docker_meme
```

While running, go to https://localhost:8787/ and login with `rstudio:<password>`


To enter the container at the commandline while running:
**NOTE:** this will enter as `root` not the `rstudio` user

```
docker run -it snystrom/bioconductor_docker_meme /bin/bash
```
