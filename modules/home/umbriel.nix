{inputs, ...}: {
  imports = [inputs.umbriel.homeModules.default];
  programs.umbriel = {
    enable = true;
    settings = {
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
        "Mod+Space" = "spawn:noctalia msg panel-toggle launcher";
        "Mod+B" = "spawn:zen-beta";
        "Mod+E" = "spawn:foot yazi $HOME";
        "Mod+Shift+E" = "spawn:nautilus";

        # Windows
        "Mod+Q" = "window-close";
        "Mod+M" = "window-toggle-maximize-to-edges";
        "Mod+F" = "window-toggle-fullscreen";
        "Mod+W" = "column-toggle-tabbed";
        "Mod+V" = "window-toggle-floating";
        "Mod+C" = "column-center";
        "Mod+Comma" = "window-consume-left";
        "Mod+Period" = "window-consume-or-expel-right";
        "Mod+BracketLeft" = "window-consume-or-expel-left";
        "Mod+BracketRight" = "window-consume-or-expel-right";

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
        "Mod+O" = "overview-toggle";
        "Mod+L" = "spawn:noctalia msg session lock";
        "Mod+Ctrl+Shift+L" = "spawn:noctalia msg session lock-and-suspend";
        "Mod+Shift+Slash" = "cheatsheet-toggle";
        "Mod+Shift+Escape" = "session-quit";

        # Layout
        "Mod+Shift+L" = "workspace-set-layout:toggle:scrolling,dwindle";

        # Screenshots
        "Print" = "spawn:noctalia msg screenshot-region";
        "Mod+Print" = "spawn:noctalia msg screenshot-annotate";
        "Ctrl+Print" = "spawn:noctalia msg screenshot-fullscreen";

        # Media
        "XF86AudioRaiseVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = {
          action = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          repeat = false;
        };
        "XF86AudioPlay" = {
          action = "spawn:playerctl play-pause";
          repeat = false;
        };
        "XF86AudioNext" = "spawn:playerctl next";
        "XF86AudioPrev" = "spawn:playerctl previous";

        # Brightness
        "XF86MonBrightnessUp" = "spawn:brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "spawn:brightnessctl set 5%-";
      };
      window_rule = [
        {corner_radius = 20;}
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
          default_maximize_to_edges = true;
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
      ];
    };
  };
}
