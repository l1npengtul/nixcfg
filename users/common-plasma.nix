{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      userEmail = "l1npengtul@protonmail.com";
      userName = "l1npengtul";
    };

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };

  home.packages = with pkgs; [fishPlugins.grc];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
    ];
  };

  xdg.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  xdg.portal.config.common.default = "kde";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
