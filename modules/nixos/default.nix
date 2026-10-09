{...}: {
  imports = [
    ./boot.nix
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

  # Pull niri and noctalia as prebuilt binaries instead of compiling them.
  nix.settings.extra-substituters = [
    "https://niri-epireyn.cachix.org"
    "https://noctalia.cachix.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
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
