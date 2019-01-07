#!/bin/bash 

curl -LJO https://github.com/whitesource/fs-agent-distribution/raw/master/standAlone/whitesource-unified-agent.jar

curl -LJO https://github.com/whitesource/fs-agent-distribution/raw/master/standAlone/whitesource-unified-agent.config

java -jar whitesource-unified-agent.jar "$@"