#!/usr/bin/env bash
set -e

cd ~/nixcfg

alejandra .

git add .

git commit  --allow-empty -m "$(date) - $@"

sudo nixos-rebuild switch --show-trace --flake .#$NIX_SWITCH_BUILD_SYSTEM_CFG_PENGPENGPENG

nix-env --delete-generations 7d

nix-store --gc
