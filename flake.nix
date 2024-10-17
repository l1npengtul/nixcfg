{
  description = "sakana fish nixos real";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

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
    ...
  }: let
    username = "l1npengtul";
    system = "x86_64-linux";
    lib = nixpkgs.lib // home-manager.lib;
  in {
    inherit lib;

    nixosConfigurations = {
      thinkpad_x1c_2in1_gen9 = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};

        modules = [
          ./configuration.nix
          ./hosts/thinkpad_x1c_2in1_gen9
          ./pkgs
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
            home-manager.sharedModules = [inputs.plasma-manager.homeManagerModules.plasma-manager];
            home-manager.users."${username}".imports = [
              nix-flatpak.homeManagerModules.nix-flatpak
              ./home.nix
              ./applications
            ];
          }

          nix-index-database.nixosModules.nix-index

          auto-cpufreq.nixosModules.default

          musnix.nixosModules.musnix

          erosanix.nixosModules.protonvpn
        ];
      };
    };
  };
}
