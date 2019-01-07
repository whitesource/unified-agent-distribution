#!/bin/bash

curl -LJO https://github.com/whitesource/unified-agent-distribution/raw/master/standAlone/whitesource-unified-agent.jar

java -jar whitesource-unified-agent.jar "$@"