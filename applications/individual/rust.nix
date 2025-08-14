{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine_dawn";
      editor = {
        line-number = "relative";
        auto-save = true;
        auto-format = true;
        auto-completion = true;
        text-width = 110;
        gutters = ["diff" "diagnostics" "line-numbers" "spacer"];
        soft-wrap.enable = true;
        soft-wrap.max-indent-retain = 80;
        mouse = true;

        lsp = {
          enable = true;
          auto-signature-help = true;
          display-messages = true;
        };

        file-picker = {
          hidden = false;
        };

        statusline = {
          left = ["mode" "spinner" "file-modification-indicator" "read-only-indicator"];
          center = ["file-name"];
          right = ["diagnostics" "register" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
          separator = "│";
          mode.normal = "LOCKED";
          mode.insert = "WORKING";
          mode.select = "VISUAL SEL";
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };

      keys.normal = {
        C-s = ":w"; # Maps Ctrl-s to the typable command :w which is an alias for :write (save file)
        C-o = ":open ~/.config/helix/config.toml"; # Maps Ctrl-o to opening of the helix config file
        a = "move_char_left"; # Maps the 'a' key to the move_char_left command
        w = "move_line_up"; # Maps the 'w' key move_line_up
        "C-S-esc" = "extend_line"; # Maps Ctrl-Shift-Escape to extend_line
        g = {a = "code_action";}; # Maps `ga` to show possible code actions
        "ret" = ["open_below" "normal_mode"]; # Maps the enter key to open_below then re-enter normal mode
      };
    };
    languages = {
      language-server.rust-analyzer = {
        command = "rust-analyzer";
        config = {
          inlayHints.bindingModeHints.enable = false;
          inlayHints.closingBraceHints.minLines = 10;
          inlayHints.closureReturnTypeHints.enable = "with_block";
          inlayHints.discriminantHints.enable = "fieldless";
          inlayHints.lifetimeElisionHints.enable = "skip_trivial";
          inlayHints.typeHints.hideClosureInitialization = false;
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
        {
          name = "rust";

          roots = ["Cargo.toml" "Cargo.lock"];

          auto-pairs = [
            "'(' = ')'"
            "'{' = '}'"
            "'[' = ']'"
            "'<' = '>'"
            '''"' = '"' ''
          ];
        }
      ];
    };
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
