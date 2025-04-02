#!/usr/bin/env bash
set -e pipefail

WHERE=$(cat /etc/hostname)

if [ -f plasma/$WHERE.nix ]; then
    rm plasma/$WHERE.nix
fi

nix run github:nix-community/plasma-manager >> plasma/$WHERE.nix

alejandra .

git commit -am "$(whoami)@${WHERE}: update plasma/${WHERE}.nix $(data)"
