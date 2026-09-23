{
  config,
  lib,
  username,
  isDarwin ? false,
  isWsl ? false,
  ...
}: let
  isLinux = !isDarwin;
  isNativeLinux = !isWsl;

  common = [
    ./cli.nix
    ./fish.nix
    ./starship.nix
    ./git.nix
    ./direnv.nix
    ./helix.nix
  ];

  linuxOnly = [
    ./foot.nix
  ];

  # non-WSL
  nativeLinuxOnly = [
    ./gaming.nix
    ./gtk.nix
    ./niri.nix
    ./noctalia.nix
    ./media.nix
    ./discord.nix
    ./zed.nix
  ];

  nativeLinuxAndDarwin = [
    ./apps.nix
  ];
in {
  imports =
    common
    ++ lib.optionals isLinux linuxOnly
    ++ lib.optionals isNativeLinux nativeLinuxOnly
    ++ lib.optionals (isNativeLinux || isDarwin) nativeLinuxAndDarwin;

  home.username = username;
  home.homeDirectory =
    if isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  # home.pointerCursor.enable = lib.mkIf isLinux true;

  home.file = lib.mkIf isLinux {
    dev.source = config.lib.file.mkOutOfStoreSymlink "/mnt/dev";
  };
}
