{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./networking.nix
    ./audio.nix
    ./hardware.nix
    ./fonts.nix
    ./umbriel.nix
    ./noctalia.nix
    ./desktop.nix
    ./stylix.nix
    ./users.nix
    ./moonshine.nix
  ];

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  nix.gc.dates = "weekly";

  # Pull niri and noctalia as prebuilt binaries instead of compiling them.
  nix.settings.extra-substituters = [
    "https://umbriel.cachix.org"
    "https://noctalia.cachix.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
  ];

  # (allowUnfree + overlays are set in flake.nix where the inputs are in scope.)

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen-beta
      '';
      mode = "0755";
    };
  };
}
