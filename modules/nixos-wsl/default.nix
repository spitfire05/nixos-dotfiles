{
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ../nixos/cache.nix
    ../nixos/stylix.nix
    ../nixos/users.nix
  ];

  # WSLg has no transparency
  stylix.opacity.terminal = lib.mkForce 1.0;

  users.users.${username}.extraGroups = [
    "wheel" # sudo
    "networkmanager"
    "video"
    "audio"
    "input"
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu
    ];
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];
}
