{
  config,
  lib,
  username,
  isDarwin ? false,
  ...
}: let
  isLinux = !isDarwin;

  common = [
    ./apps.nix
    ./cli.nix
    ./fish.nix
    ./starship.nix
    ./git.nix
    ./direnv.nix
    ./claude-code.nix
    ./helix.nix
  ];

  linuxOnly = [
    ./ghostty.nix
    ./gtk.nix
    ./niri.nix
    ./noctalia.nix
    ./media.nix
    ./discord.nix
    ./zed.nix
  ];
in {
  imports = common ++ lib.optionals isLinux linuxOnly;

  home.username = username;
  home.homeDirectory =
    if isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.pointerCursor.enable = lib.mkIf isLinux true;

  home.file = lib.mkIf isLinux {
    dev.source = config.lib.file.mkOutOfStoreSymlink "/mnt/dev";
  };
}
