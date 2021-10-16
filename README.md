# Dockerized Unifed-Agent

Refer to https://github.com/whitesource/unified-agent-distribution/blob/master/dockerized/README.md for customization and original setup directions

## Differences 

* Upgraded NodeJS to 12.x
* Downgrades Cocoapods to 1.10.2
* Uses ENV Variables & default values instead of a config file

## Build Directions: 

### Less Package Managers
```
docker build ./ -t dockerua:thin
```
### All Package Managers
```
cd ./Full
docker build ./ -t dockerua:full
```
## Usage Directions
* Required ENV Variables
    * WS_APIKEY
    * WS_PRODUCTNAME
    * WS_PROJECTNAME
    * SCANDIR
```
cd <your cloned directory>
export WS_APIKEY=<your-apikey>
export SCANDIR=$(pwd)
export WS_PRODUCTNAME=$(git config --get remote.origin.url | awk -F "/" '{print $4}')
export WS_PROJECTNAME=$(git config --get remote.origin.url | awk -F "/" '{print $5}' | awk -F "." '{print $1}')

docker run --rm --name dockerua \
--mount type=bind,source=$SCANDIR,target=/home/wss-scanner/Data/ \
-e WS_APIKEY=$WS_APIKEY \
-e WS_PRODUCTNAME=$WS_PRODUCTNAME \
-e WS_PROJECTNAME=$WS_PROJECTNAME dockerua:thin
```
