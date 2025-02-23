#!/usr/bin/env bash
set -e pipefail

WHERE=$(cat /etc/hostname)

rm plasma/$WHERE.nix

nix run github:nix-community/plasma-manager >> plasma/$WHERE.nix

alejandra .

git commit -am "$(whoami)@${WHERE}: update plasma/${WHERE}.nix $(data)"
