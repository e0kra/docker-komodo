# Dockerized komodo (node & wallet)

This will create a fully functional [Komodo](https://komodoplatform.com/) Komodo docker image.

Available on [Docker Hub](https://hub.docker.com/r/e0kra/komodo/).

## Build

    docker build --tag e0kra/komodo .

## Tag & Push

    docker push e0kra/komodo

## Download

    docker pull e0kra/komodo

## Run

Simplest version:

    docker run -d --name komodo -p 7770:7770 -v $HOME/.komodo:/root/.komodo -v $HOME/.zcash-params:/root/.zcash-params:ro e0kra/komodo
