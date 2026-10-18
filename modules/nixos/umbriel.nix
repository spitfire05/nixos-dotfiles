{
  pkgs,
  inputs,
  username,
  ...
}: {
  programs.umbriel.enable = true;

  # Minimal graphical login: tuigreet drops you straight into a niri session.
  # Flip `services.greetd.settings.default_session.user` to your username and
  # set `initial_session` instead of `default_session` to autologin.
  services.greetd = {
    enable = true;
    settings.initial_session = {
      command = "niri-session";
      user = username;
    };
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-umbriel";
      user = "greeter";
    };
  };

  # Brightness keys are handled by brightnessctl (installed in desktop.nix),
  # which talks to logind and needs no extra privileges in a session.
}
