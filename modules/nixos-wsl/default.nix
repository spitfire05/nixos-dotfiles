{...}: {
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

  # For vscode-server to work on NixOS-WSL:
  programs.nix-ld.enable = true;

  # A lean system-wide package set; everything user-facing lives in home-manager.
  environment.systemPackages = [];

  environment.sessionVariables.MANROFFOPT = "-c";
  environment.sessionVariables.MANPAGER = "sh -c 'col -bx | bat -l man -p'";
}
