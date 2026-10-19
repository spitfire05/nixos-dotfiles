{inputs, ...}: {
  imports = [inputs.umbriel.homeModules.default];
  programs.umbriel = {
    enable = true;
    settings = {
      general.show_cheatsheet = false;
      workspace = [
        {name = "web";}
        {name = "dev";}
        {name = "game";}
        {name = "media";}
        {name = "chat";}
      ];
      layout.scrolling = {
        default_extent_fraction = 0.5;
      };
      input = {
        keyboard.layout = "pl";
        mouse = {
          natural_scroll = true;
          accel_profile = "flat";
        };
        cursor = {
          follows_focus = true;
        };
      };
      keybinds = {
        # Launchers
        "Mod+Return" = {
          action = "spawn:foot";
          repeat = false;
        };
        "Mod+Space" = {
          action = "spawn:noctalia msg panel-toggle launcher";
          repeat = false;
        };
        "Mod+B" = {
          action = "spawn:zen-beta";
          repeat = false;
        };
        "Mod+E" = {
          action = "spawn:foot yazi $HOME";
          repeat = false;
        };
        "Mod+Shift+E" = {
          action = "spawn:nautilus";
          repeat = false;
        };

        # Windows
        "Mod+Q" = {
          action = "window-close";
          repeat = false;
        };
        "Mod+M" = {
          action = "window-toggle-maximize-to-edges";
          repeat = false;
        };
        "Mod+F" = {
          action = "window-toggle-fullscreen";
          repeat = false;
        };
        "Mod+W" = {
          action = "column-toggle-tabbed";
          repeat = false;
        };
        "Mod+V" = {
          action = "window-toggle-floating";
          repeat = false;
        };
        "Mod+C" = "column-center";
        "Mod+Comma" = "window-consume-left";
        "Mod+Period" = "window-consume-or-expel-right";
        "Mod+BracketLeft" = "window-consume-or-expel-left";
        "Mod+BracketRight" = "window-consume-or-expel-right";
        "Alt+Tab" = {
          action = "spawn:noctalia msg window-switcher hold";
          repeat = false;
        };
        "Mod+T" = {
          action = "window-toggle-floating";
          repeat = false;
        };
        "Mod+Shift+T" = {
          action = "window-focus-switch-floating";
          repeat = false;
        };

        # Focus
        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+Alt+Left" = "column-focus-tab-previous";
        "Mod+Alt+Right" = "column-focus-tab-next";
        "Mod+Down" = "window-focus-down";
        "Mod+Up" = "window-focus-up";

        # Move
        "Mod+Shift+Left" = "column-move-left";
        "Mod+Shift+Right" = "column-move-right";
        "Mod+Shift+Down" = "window-move-down";
        "Mod+Shift+Up" = "window-move-up";

        # Sizing
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Minus" = "window-modify-primary-extent:-0.1";
        "Mod+Equal" = "window-modify-primary-extent:0.1";
        "Mod+Shift+Minus" = "window-modify-secondary-extent:-0.1";
        "Mod+Shift+Equal" = "window-modify-secondary-extent:0.1";

        # Workspaces
        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+Shift+1" = "column-move-to-workspace:1";
        "Mod+Shift+2" = "column-move-to-workspace:2";
        "Mod+Shift+3" = "column-move-to-workspace:3";
        "Mod+Shift+4" = "column-move-to-workspace:4";
        "Mod+Shift+5" = "column-move-to-workspace:5";
        "Mod+Alt+Down" = "workspace-next";
        "Mod+Alt+Up" = "workspace-previous";

        # Overview & session
        "Mod+O" = {
          action = "overview-toggle";
          repeat = false;
        };
        "Mod+L" = {
          action = "spawn:noctalia msg session lock";
          repeat = false;
        };
        "Mod+Ctrl+Shift+L" = {
          action = "spawn:noctalia msg session lock-and-suspend";
          repeat = false;
        };
        "Mod+Shift+Slash" = {
          action = "cheatsheet-toggle";
          repeat = false;
        };
        "Mod+Shift+Escape" = "session-quit";

        # Layout
        "Mod+Shift+L" = {
          action = "workspace-set-layout:toggle:scrolling,dwindle";
          repeat = false;
        };

        # Scratchpad
        "Mod+Alt+S" = "window-move-to-scratchpad";
        "Mod+S" = {
          action = "scratchpad-toggle";
          repeat = false;
        };
        "Mod+Ctrl+S" = "window-restore-from-scratchpad";
        "Mod+Tab" = "scratchpad-focus-next";

        # Screenshots
        "Print" = {
          action = "spawn:noctalia msg screenshot-region";
          repeat = false;
        };
        "Mod+Print" = {
          action = "spawn:noctalia msg screenshot-annotate";
          repeat = false;
        };
        "Ctrl+Print" = {
          action = "spawn:noctalia msg screenshot-fullscreen";
          repeat = false;
        };

        # Media
        "XF86AudioRaiseVolume" = {
          action = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          repeat = false;
        };
        "XF86AudioLowerVolume" = {
          action = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          repeat = false;
        };
        "XF86AudioMute" = {
          action = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          repeat = false;
        };
        "XF86AudioPlay" = {
          action = "spawn:playerctl play-pause";
          repeat = false;
        };
        "XF86AudioNext" = {
          action = "spawn:playerctl next";
          repeat = false;
        };
        "XF86AudioPrev" = {
          action = "spawn:playerctl previous";
          repeat = false;
        };

        # Brightness
        "XF86MonBrightnessUp" = {
          action = "spawn:brightnessctl set 5%+";
          repeat = false;
        };
        "XF86MonBrightnessDown" = {
          action = "spawn:brightnessctl set 5%-";
          repeat = false;
        };
      };
      window_rule = [
        {corner_radius = 20;}
        {blur = true;}
        {
          match.app_id = "^dev.noctalia.Noctalia$";
          default_floating = true;
          default_floating_size_px = {
            width = 1080;
            height = 920;
          };
        }
        {
          match.app_id = "^rapidraw$";
          default_workspace = "media";
          default_maximize_to_edges = true;
        }
        {
          match.app_id = "^Spotify$";
          default_workspace = "media";
          default_maximize_to_edges = true;
        }
        {
          match.app_id = "^steam$";
          default_workspace = "game";
          default_maximize_to_edges = true;
        }
        {
          match.app_id = "^curseforge$";
          default_workspace = "game";
        }
        {
          match.app_id = "^zen-beta$";
          default_workspace = "web";
        }
        {
          match.app_id = "^vesktop$";
          default_workspace = "chat";
          default_maximize_to_edges = true;
        }
        {
          match.app_id = "^signal$";
          default_workspace = "chat";
        }
        {
          match.title = "^(Picture-in-Picture|Picture in picture)$";
          default_floating = true;
          default_maximize = false;
          default_position = {
            x = 20;
            y = 20;
            anchor = "bottom_right";
          };
        }
      ];
    };
  };
}
