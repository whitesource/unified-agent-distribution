#!/bin/bash

curl -LJO https://github.com/whitesource/unified-agent-distribution/raw/master/standAlone/wss-unified-agent.jar

java -jar wss-unified-agent.jar "$@"
