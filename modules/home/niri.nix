{local, ...}: {
  programs.niri.settings = {
    # Stylix's niri target sets border/focus-ring colors and the cursor, so we
    # only describe behaviour here.

    prefer-no-csd = true;

    input = {
      keyboard.xkb = {
        layout = "pl";
      };
      # Each window remembers its own layout ("global" = one shared layout).
      keyboard.track-layout = "window";
      touchpad = {
        tap = true;
        natural-scroll = true;
        dwt = true; # disable-while-typing
      };
      mouse = {
        accel-profile = "flat";
        natural-scroll = true; # match macOS-style scrolling (also set on touchpad)
      };
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus.enable = true;
    };

    # ⇩ EDIT ME: name your outputs (`niri msg outputs` lists them) for scale/pos.
    outputs."eDP-1" = {
      scale = local.monitorScale;
    };

    layout = {
      gaps = 12;
      always-center-single-column = true;
      center-focused-column = "never";
      preset-column-widths = [
        {proportion = 1.0 / 3.0;}
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
      ];
      default-column-width.proportion = 1.0 / 2.0;
      # Stylix disables the focus-ring and themes the border instead, then we
      # disable that border below — so re-enable the ring explicitly here or
      # nothing gets drawn. Thin, soft Kanagawa foreground on the focused
      # window; transparent on the rest so only the selected one is outlined.
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#cba6f7"; # Catppuccin Mocha Mauve
        inactive.color = "#00000000";
      };
      border.enable = false;
    };

    # noctalia is started as a systemd user service bound to the niri session
    # (see modules/home/noctalia.nix), so no spawn-at-startup needed.

    # Subtle, fast animations — omarchy-style polish without distraction.
    animations.slowdown = 0.7;

    hotkey-overlay.skip-at-startup = true;

    # Make the wallpaper stationary, rather than moving with workspaces.
    layer-rules = [
      {
        matches = [
          {namespace = "^noctalia-backdrop";}
        ];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      # Rounder corners to match Noctalia's style
      {
        geometry-corner-radius = {
          bottom-left = 20.0;
          bottom-right = 20.0;
          top-left = 20.0;
          top-right = 20.0;
        };
        clip-to-geometry = true;
      }

      # Floating Noctalia settings window
      {
        matches = [
          {app-id = "dev.noctalia.Noctalia";}
        ];
        open-floating = true;
        default-column-width = {
          fixed = 1080;
        };
        default-window-height = {
          fixed = 920;
        };
      }
    ];

    # niri-flake's canonical attribute form: `action.<name> = <args>`. No-arg
    # actions take `{ }`; spawn takes a string or a list of argv strings.
    binds = {
      # Launchers
      "Mod+Return".action.spawn = "ghostty";
      # Noctalia v5 IPC: `noctalia msg <command>` (the old `ipc call` form and
      # the `noctalia-shell` binary are gone). The launcher is a named panel.
      "Mod+Space".action.spawn = [
        "noctalia"
        "msg"
        "panel-toggle"
        "launcher"
      ];
      "Mod+B".action.spawn = "zen-beta"; # browser
      "Mod+E".action.spawn = "nautilus"; # file manager

      # Window management
      "Mod+Q".action.close-window = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+W".action.toggle-column-tabbed-display = {};
      "Mod+V".action.toggle-window-floating = {};
      "Mod+C".action.center-column = {};
      "Mod+Comma".action.consume-window-into-column = {};
      "Mod+Period".action.expel-window-from-column = {};
      "Mod+BracketLeft".action.consume-or-expel-window-left = {};
      "Mod+BracketRight".action.consume-or-expel-window-right = {};

      # Focus
      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};

      # Move
      "Mod+Shift+Left".action.move-column-left = {};
      "Mod+Shift+Right".action.move-column-right = {};
      "Mod+Shift+Down".action.move-window-down = {};
      "Mod+Shift+Up".action.move-window-up = {};

      # Sizing
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Alt+Down".action.focus-workspace-down = {};
      "Mod+Alt+Up".action.focus-workspace-up = {};

      "Mod+O".action.toggle-overview = {};
      "Mod+L".action.spawn = [
        "noctalia"
        "msg"
        "session"
        "lock"
      ];
      "Mod+Ctrl+Shift+L".action.spawn = [
        "noctalia"
        "msg"
        "session"
        "lock-and-suspend"
      ];

      # Screenshots
      "Print".action.screenshot = {};
      "Mod+Print".action.screenshot-window = {};
      "Ctrl+Print".action.screenshot-screen = {};

      # Help + session
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};
      "Mod+Shift+E".action.quit = {};

      # Media / brightness keys
      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
      "XF86AudioNext".action.spawn = ["playerctl" "next"];
      "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
      # Internal panel. modules/nixos/apple-studio-display.nix overrides these to
      # also drive a docked Apple Studio Display when that module is enabled.
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "5%+"];
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
    };
  };
}
