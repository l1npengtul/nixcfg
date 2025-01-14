{
  description = "sakana fish nixos real";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    plugdata-pr.url = "github:l1npengtul/nixpkgs/update-plugdata";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    audio = {
      url = "github:polygon/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    erosanix.url = "github:emmanuelrosa/erosanix";

    gradle2nix = {
      url = "github:tadfisher/gradle2nix/v2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    vhs-decode-nur-packages.url = "github:JuniorIsAJitterbug/nur-packages";
    nix-matlab = {
      # nix-matlab's Nixpkgs input follows Nixpkgs' nixos-unstable branch. However
      # your Nixpkgs revision might not follow the same branch. You'd want to
      # match your Nixpkgs and nix-matlab to ensure fontconfig related
      # compatibility.
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    systems,
    plasma-manager,
    nix-flatpak,
    auto-cpufreq,
    musnix,
    nixos-hardware,
    audio,
    erosanix,
    gradle2nix,
    nix-index-database,
    vhs-decode-nur-packages,
    nix-matlab,
    nixpkgs-stable,
    nixpkgs-master,
    plugdata-pr,
    ...
  }: let
    username = "l1npengtul";
    system = "x86_64-linux";
    lib = nixpkgs.lib // home-manager.lib;
    pkgs = import nixpkgs commonArgs;
    pkgs-stable = import nixpkgs-stable commonArgs;
    pkgs-master = import nixpkgs-master commonArgs;
    commonArgs = {
      inherit system;
      inherit pkgs;
      config.allowUnfree = true;
    };
  in {
    inherit lib;

    nixosConfigurations = {
      oldhome = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit pkgs-master;
        };

        modules = [
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-hidpi
          nixos-hardware.nixosModules.lenovo-thinkpad

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit pkgs-stable;
            };
            home-manager.sharedModules = [inputs.plasma-manager.homeManagerModules.plasma-manager];
            home-manager.users."${username}".imports = [
              nix-flatpak.homeManagerModules.nix-flatpak
              ./users/l1npengtul.nix
              ./applications
            ];
          }

          nix-index-database.nixosModules.nix-index

          auto-cpufreq.nixosModules.default

          musnix.nixosModules.musnix

          erosanix.nixosModules.protonvpn

          ./configuration.nix
          ./hosts/oldhome
          ./pkgs
        ];
      };
      abandonedfactory = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit pkgs-stable;
        };

        modules = [
          ./configuration.nix
          ./hosts/abandonedfactory
          ./pkgs/default_server.nix

          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-pc-ssd

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [inputs.plasma-manager.homeManagerModules.plasma-manager];
            home-manager.users.pengsrv.imports = [
              ./users/pengsrv.nix
              ./applications/individual/default_server.nix
            ];
          }

          nix-index-database.nixosModules.nix-index
        ];
      };
    };
  };
}
