{lib, ...}: {
  imports = [
    ./networking.nix
    ./fonts.nix
    ../nixos/stylix.nix
    ./users.nix
  ];

  # No cursor theming, different mono font name on Darwin
  stylix.opacity.terminal = lib.mkForce 1.0;
  stylix.fonts.monospace.name = lib.mkForce "JetbrainsMono Nerd Font Mono";

  # (allowUnfree + overlays are set in flake.nix where the inputs are in scope.)
}
