{
  description = "sakana fish nixos real";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    bitwig-pr.url = "github:l1npengtul/nixpkgs/update-bitwig";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    agenix.url = "github:ryantm/agenix";

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

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
    flux.url = "github:l1npengtul/flux";
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
    nixpkgs-stable,
    nixpkgs-master,
    nix-minecraft,
    playit-nixos-module,
    agenix,
    flux,
    bitwig-pr,
    ...
  }: let
    username = "l1npengtul";
    system = "x86_64-linux";
    lib = nixpkgs.lib // home-manager.lib;
    commonArgs = {
      inherit system;
      inherit pkgs;
      overlays = [inputs.nix-minecraft.overlay inputs.flux.overlays.default];
      config.allowUnfree = true;
    };
    pkgs = import nixpkgs commonArgs;
    pkgs-stable = import nixpkgs-stable commonArgs;
    pkgs-master = import nixpkgs-master commonArgs;
  in {
    inherit lib;

    nixosConfigurations = {
      s-23sierpinski = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit pkgs-master;
        };

        modules = [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-hidpi

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
              ./applications/flatpak.nix
              ./applications/individual/blender.nix
              ./applications/individual/krita.nix
              ./applications/individual/kdeconnect.nix
              ./applications/individual/vlc.nix
              ./applications/individual/ktorrent.nix
              ./applications/individual/direnv.nix
              ./applications/individual/bottles.nix
              ./applications/individual/firefox.nix
              ./plasma/s-23sierpinski.nix
            ];
          }

          nix-index-database.nixosModules.nix-index

          auto-cpufreq.nixosModules.default

          musnix.nixosModules.musnix

          erosanix.nixosModules.protonvpn

          ./configuration.nix
          ./hosts/s-23sierpinski
          ./pkgs/archives.nix
          ./pkgs/java.nix
          ./pkgs/nix-utils.nix
          ./pkgs/sysutils.nix
          ./pkgs/python3.nix
          ./pkgs/kdegtk.nix
          ./pkgs/fcitx5
          ./pkgs/fonts
          ./pkgs/libvirtd.nix
          ./pkgs/protonvpn.nix
          ./pkgs/tailscale-client.nix
          ./pkgs/input.nix
          ./pkgs/diskmgmt.nix
          ./pkgs/sshd.nix
        ];
      };

      pegrose512 = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit pkgs-master;
        };

        modules = [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-hidpi

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit pkgs;
              inherit pkgs-stable;
            };
            home-manager.sharedModules = [inputs.plasma-manager.homeManagerModules.plasma-manager];
            home-manager.users."${username}".imports = [
              nix-flatpak.homeManagerModules.nix-flatpak
              ./users/l1npengtul.nix
              ./applications
              ./plasma/pegrose512.nix
            ];
          }

          nix-index-database.nixosModules.nix-index

          auto-cpufreq.nixosModules.default

          musnix.nixosModules.musnix

          erosanix.nixosModules.protonvpn

          ./configuration.nix
          ./hosts/pegrose512
          ./pkgs
        ];
      };
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
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-hidpi
          nixos-hardware.nixosModules.lenovo-thinkpad

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit pkgs-stable;
              inherit pkgs-master;
            };
            home-manager.sharedModules = [inputs.plasma-manager.homeManagerModules.plasma-manager];
            home-manager.users."${username}".imports = [
              nix-flatpak.homeManagerModules.nix-flatpak
              ./users/l1npengtul.nix
              ./applications
              ./plasma/oldhome.nix
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
          inherit pkgs-stable;
        };

        modules = [
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-pc-ssd
          flux.nixosModules.default
          playit-nixos-module.nixosModules.default
          nix-minecraft.nixosModules.minecraft-servers
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
          agenix.nixosModules.default
          {
            age.secrets.playit-secret.file = ./secrets/playit-secret.age;
            age.secrets.cloudflared-secret-abandonedfactory.file = ./secrets/cloudflared-secret-abandonedfactory.age;
            age.secrets.cloudflared-minecraftproxy-secret = {
              file = ./secrets/cloudflared-minecraftproxy-secret.age;
              mode = "755";
            };
          }
          nix-index-database.nixosModules.nix-index
          ./configuration.nix
          ./hosts/abandonedfactory
          ./pkgs/default_server.nix
          ./services
        ];
      };
    };
  };
}
