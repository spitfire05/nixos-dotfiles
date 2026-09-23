{
  config,
  lib,
  username,
  local,
  isDarwin ? false,
  isWsl ? false,
  ...
}: let
  isLinux = !isDarwin;

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
    ++ lib.optionals (!isWsl) nativeLinuxOnly
    ++ lib.optionals (!isWsl || isDarwin) nativeLinuxAndDarwin;

  home.username = username;
  home.homeDirectory =
    if isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.pointerCursor.enable = lib.mkIf (isLinux && !isWsl) true;

  home.file = lib.mkIf (local.hostName == "michal-pc") {
    dev.source = config.lib.file.mkOutOfStoreSymlink "/mnt/dev";
  };
}
