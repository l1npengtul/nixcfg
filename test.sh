#!/usr/bin/env bash
set -e

cd ~/nixcfg

alejandra .

git add .

git commit  --allow-empty -m "TEST: $(whoami): $(date) - $@"

nixos-rebuild build --fast --show-trace --verbose --print-build-logs --flake .#$NIX_SWITCH_BUILD_SYSTEM_CFG_PENGPENGPENG
