#!/usr/bin/env bash

SYSTEM_ARCHITECTURE=linux-x86_64
PATH_DOCKER_CLI_PLUGINS=/usr/local/lib/docker/cli-plugins
mkdir -p $PATH_DOCKER_CLI_PLUGINS
curl -SL "$(curl -s https://api.github.com/repos/docker/compose/releases/latest|jq -r '.assets | map(select(.name | contains("'$SYSTEM_ARCHITECTURE'"))) | .[0].browser_download_url')" -o $PATH_DOCKER_CLI_PLUGINS/docker-compose
chmod +x $PATH_DOCKER_CLI_PLUGINS/docker-compose
