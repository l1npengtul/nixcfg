#!/usr/bin/env bash
set -e

cd ~/nixcfg

alejandra .

git add .

git commit  --allow-empty -m "$(whoami): $(date) - $@"

nixos-rebuild build --fast --show-trace --flake --verbost -L --print-build-logs .#$NIX_SWITCH_BUILD_SYSTEM_CFG_PENGPENGPENG
