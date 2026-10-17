{inputs, ...}: {
  imports = [inputs.umbriel.homeModules.default];
  programs.umbriel = {
    enable = true;
    settings = {
      general.autostart = ["noctalia"];
      layout.gap = 5;
      input = {
        keyboard.layout = "pl";
        mouse = {
          natural_scroll = true;
          accel_profile = "flat";
        };
      };
      keybinds = {
        "Mod+Return" = {
          action = "spawn:foot";
          repeat = false;
        };
        "Mod+Q" = "window-close";
        "Mod" = "spawn:noctalia msg panel-toggle launcher";

        # Focus
      };
    };
  };
}
