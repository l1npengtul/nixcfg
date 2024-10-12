#!/bin/bash

cd ~/pengcfg

git add .

git commit -am "$(date) - $@"


alejandra .

sudo nixos-rebuild switch --show-trace --flake .#$NIX_SWITCH_BUILD_SYSTEM_CFG_PENGPENGPENG

nix-env --delete-generations 7d

nix-store --gc
