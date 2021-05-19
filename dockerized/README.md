`# Dockerized Unified-Agent

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

* Do not use relative paths for the SCANDIR variable, as docker --mount only accepts full paths

```
export WS_APIKEY=<your-apikey>
export SCANDIR=<full path name of directory to scan>

# example scan directory
# export SCANDIR=home/userxyz/Documents/Code/SampleApplication

docker run --rm --name docker-ua --mount type=bind,source=$SCANDIR,target=/home/wss-scanner/Data/ -e WS_APIKEY=$WS_APIKEY -e WS_PRODUCTNAME=<your-product-name> -e WS_PROJECTNAME=<your-project-name> 

```