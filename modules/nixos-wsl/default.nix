{pkgs, ...}: {
  imports = [
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

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu
    ];
  };

  # A lean system-wide package set; everything user-facing lives in home-manager.
  environment.systemPackages = [];

  environment.sessionVariables.MANROFFOPT = "-c";
  environment.sessionVariables.MANPAGER = "sh -c 'col -bx | bat -l man -p'";
}
