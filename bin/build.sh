#!/bin/bash

# Fetch latest version
export LATEST_VERSION=$(curl --silent "https://api.github.com/repos/clivern/bandit/releases/latest" | jq '.tag_name' | sed -E 's/.*"([^"]+)".*/\1/')
