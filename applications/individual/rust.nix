{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine_dawn";
      editor = {
        lsp.display-messages = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
      {
        name = "rust";
        auto-format = true;
      }
    ];
  };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This will hold the configuration.
      local config = wezterm.config_builder()

      -- This is where you actually apply your config choices.

      -- For example, changing the initial geometry for new windows:
      config.initial_cols = 120
      config.initial_rows = 28

      -- or, changing the font size and color scheme.
      config.font_size = 12
      config.font = wezterm.font("ComicShannsMono Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})
      config.color_scheme = 'Sakura (base16)'

      -- Finally, return the configuration to wezterm:
      return config
    '';
  };
}
