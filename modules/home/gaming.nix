{
  pkgs,
  lib,
  ...
}: {
  programs.mangohud = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    settings = {
      preset = 3;
      no_display = true;
      font_size = lib.mkForce 24; # Forced because of confilct with stylix
      vram = true;
      ram = true;
      swap = true;
      display_server = true;
      wine = true;
      winesync = true;
      gamemode = true;
    };
  };

  home.packages = with pkgs; [
    gamescope

    # Custom wrapper to run games with gamemoderun + mangohud + selected Proton envs.
    # When MOONSHINE_CLIENT_FRAMERATE is present (i.e. the game was launched by
    # Moonshine for a remote client), we addiotnally wrap the game in gamescope.
    (writeShellScriptBin "gamerun" ''
      if [ $# -eq 0 ]; then
        printf 'Usage: %s command [args...]\n' "''${0##*/}" >&2
        exit 2
      fi

      ENV=(
        "PROTON_DLSS_UPGRADE=1"
        "PROTON_USE_NTSYNC=1"
        "DXVK_ASYNC=1"
        "PROTON_ENABLE_NVAPI=1"
        "PROTON_ENABLE_WAYLAND=1"
      )

      if [ -z "''${MOONSHINE_CLIENT_FRAMERATE:-}" ]; then
        exec gamemoderun mangohud env "''${ENV[@]}" "''$@"
      else
        exec gamemoderun env "''${ENV[@]}" gamescope -f \
        -W "''$MOONSHINE_CLIENT_WIDTH" \
        -H "''$MOONSHINE_CLIENT_HEIGHT" \
        -w "''$MOONSHINE_CLIENT_WIDTH" \
        -h "''$MOONSHINE_CLIENT_HEIGHT" \
        -r "''$MOONSHINE_CLIENT_FRAMERATE" \
        -- "''$@"
      fi
    '')
  ];
}
