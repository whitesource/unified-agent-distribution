# Dockerized Unifed-Agent

Refer to https://github.com/whitesource/unified-agent-distribution/blob/master/dockerized/README.md for customization and original setup directions

## Differences 

* Upgraded NodeJS to 12.x

## Build Directions: 

```
git clone <this repository>
cd ./dockerized
./wss_agent.sh
docker build ./ -t docker-ua

```
## Usage Directions

```
export WS_APIKEY=<your-apikey>
export SCANDIR=<your directory to scan>

# example scan directory
# export SCANDIR=/Documents/Code/NodeGoat

docker run --rm --name docker-ua --mount type=bind,source=$(pwd)$SCANDIR,target=/home/wss-scanner/Data/ -e WS_APIKEY=$WS_APIKEY -e WS_PRODUCTNAME=docker-ua -e WS_PROJECTNAME=nodegoat-ua docker-ua 

```
