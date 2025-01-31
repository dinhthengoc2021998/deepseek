#!/bin/bash

docker build -t open-webui-custom:latest -f Dockerfile --target open-webui-custom .
docker build -t ollama-custom:latest --debug -f Dockerfile --target ollama-custom .
