{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./cache.nix
    ./networking.nix
    ./audio.nix
    ./hardware.nix
    ./fonts.nix
    ./niri.nix
    ./noctalia.nix
    ./desktop.nix
    ./stylix.nix
    ./users.nix
    ./moonshine.nix
  ];

  # For Zed LSPs to work in NixOS
  programs.nix-ld.enable = true;

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  nix.gc.dates = "weekly";

  # (allowUnfree + overlays are set in flake.nix where the inputs are in scope.)

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen-beta
      '';
      mode = "0755";
    };
  };

  # Don't style GTK source view, as it currently triggers binary cache misses -> long rebuilds
  # https://github.com/nix-community/stylix/issues/2318
  stylix.targets.gtksourceview.enable = false;
}
