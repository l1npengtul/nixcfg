#!/usr/bin/env bash
set -e

cd ~/nixcfg

alejandra .

git add .

git commit  --allow-empty -m "TEST: $(whoami)@$(cat /etc/hostname): $(date) - $@"

nixos-rebuild build --fast --show-trace --verbose --print-build-logs --flake .#$(cat /etc/hostname)
