#!/usr/bin/env bash
set -e

cd ~/nixcfg

WHERE=$(cat /etc/hostname)

alejandra .

git add .

git commit  --allow-empty -m "$(whoami)@${WHERE}: $(date) - $@"

sudo nixos-rebuild switch --show-trace --flake --fast --verbose --print-build-logs .#$WHERE
