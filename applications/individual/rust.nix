{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine_dawn";
      editor = {
        line-number = "relative";
        scroll-lines = 7;
        mouse = true;
        clipboard-provider = "wayland";

        completion-timeout = 5;
        completion-replace = true;

        bufferline = "always";

        lsp = {
          enable = true;
          auto-signature-help = true;
          display-messages = true;
        };

        file-picker = {
          hidden = false;
        };

        soft-wrap = {
          enable = true;
        };

        statusline = {
          left = ["mode" "spinner" "file-name" "file-modification-indicator" "read-only-indicator"];
          center = ["version-control"];
          right = ["diagnostics" "workspace-diagnostics" "selections" "register" "position" "total-line-numbers" "file-encoding"];
        };

        auto-save = {
          after-delay.enable = true;
          after-delay.timeout = 500;
        };

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "hint";
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
      language-server.rust-analyzer.config = {
        cargo = {all-features = true;};
        procMacro = {enable = true;};
        imports = {
          granularity.group = "item";
          prefix = "by_crate";
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
          auto-format = "true";
          rulers = [100];
        }
        {
          name = "markdown";
          rulers = [80];
        }
      ];
    };
  };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm';
      local config = {}

      config.window_frame = {
        font = wezterm.font { family = 'rainyhearts' },
        font_size = 16.0,
      }

      config.window_decorations = 'RESIZE'
      config.color_scheme = 'Rosé Pine Dawn (base16)'
      config.window_background_opacity = 0.8
      config.text_background_opacity = 0.8
      config.leader = { key = 'a', mods = 'CTRL' }
      config.font = wezterm.font 'ComicShannsMono Nerd Font'
      config.keys = {
        {
          key = 'LeftArrow',
          mods = 'CTRL',
          action = wezterm.action.ActivateTabRelative(-1),
        },
        {
          key = 'RightArrow',
          mods = 'CTRL',
          action = wezterm.action.ActivateTabRelative(1),
        },
        {
          key = 'm',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.SplitVertical {domain = "CurrentPaneDomain"},
        },
        {
          key = 'n',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.SplitHorizontal {domain = "CurrentPaneDomain"},
        },
        {
          key = 'LeftArrow',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.AdjustPaneSize {'Left', 2},
        },
        {
          key = 'UpArrow',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.AdjustPaneSize {'Down', 2},
        },
        {
          key = 'DownArrow',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.AdjustPaneSize {'Up', 2},
        },
        {
          key = 'RightArrow',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.AdjustPaneSize {'Right', 2},
        },
        {
          key = 'h',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
          key = 'j',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.ActivatePaneDirection 'Down',
        },
        {
          key = 'k',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.ActivatePaneDirection 'Up',
        },
        {
          key = 'l',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
          key = 'l',
          mods = 'LEADER',
          action = wezterm.action.ShowDebugOverlay,
        },
        {
          key = 'q',
          mods = 'CTRL',
          action = wezterm.action.CloseCurrentPane {confirm = true},
        },
        {
          key = 'q',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.CloseCurrentPane {confirm = false},
        },
        {
          key = '`',
          mods = 'CTRL',
          action = wezterm.action.SendString('fg\n'),
        }
      }

      for i = 1, 9 do
        table.insert(config.keys, {
          key = tostring(i),
          mods = 'CTRL',
          action = wezterm.action.ActivateTab(i - 1),
        })
      end

      return config

    '';
  };
}
