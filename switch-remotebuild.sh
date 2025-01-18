#!/usr/bin/env bash
set -e

cd ~/nixcfg

WHERE=$(cat /etc/hostname)

alejandra .

git add .

git commit  --allow-empty -m "$(whoami)@${WHERE}: $(date)"

sudo nixos-rebuild switch --show-trace --build-host pengsrv@100.123.116.107  --flake .#$WHERE

nix-env --delete-generations 7d

nix-store --gc

