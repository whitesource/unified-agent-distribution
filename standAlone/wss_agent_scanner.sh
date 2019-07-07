#!/bin/bash

curl -LJO https://github.com/whitesource/unified-agent-distribution/releases/latest/download/wss-unified-agent.jar

java -jar wss-unified-agent.jar "$@"
