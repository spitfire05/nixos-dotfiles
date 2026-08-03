{...}: {
  imports = [
    ./networking.nix
    ./fonts.nix
    ./stylix.nix
    ./users.nix
  ];

  # Flakes + the modern nix CLI.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # (allowUnfree + overlays are set in flake.nix where the inputs are in scope.)

  # A lean system-wide package set; everything user-facing lives in home-manager.
  environment.systemPackages = [];

  environment.variables.MANROFFOPT = "-c";
  environment.variables.MANPAGER = "sh -c 'col -bx | bat -l man -p'";

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen-beta
      '';
      mode = "0755";
    };
  };
}
