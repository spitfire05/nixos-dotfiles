{
  lib,
  pkgs,
  username,
  isDarwin,
  ...
}: {
  # ── Tools with a home-manager program module ──────────────────────────────
  # Using programs.* (rather than raw packages) gets us shell integration and
  # Stylix theming for free.

  programs.lsd = {
    enable = true;
    settings = {
      date = "relative";
      icons.when = "auto";
    };
  };

  # Alactritty on Darwin, as ghostty is not available
  programs.alacritty = {
    enable = lib.mkIf isDarwin true;
    settings = {
      terminal.shell = "${pkgs.fish}/bin/fish";
    };
  };

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.zellij.enable = true;
  programs.jq.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd cd"]; # `cd` becomes smart, keeps muscle memory.
  };
  # home-manager loads `zoxide init` near the top of .zshrc, but direnv
  # inits afterwards and re-touches chpwd_functions. zoxide's startup "doctor"
  # heuristic wants to be initialized last, so it prints a one-off
  # "possible configuration issue" warning even though the hook is registered
  # and tracking works fine. Silence the false positive.
  home.sessionVariables._ZO_DOCTOR = "0";

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  # ── Everything else ───────────────────────────────────────────────────────
  home.packages = with pkgs; [
    # navigation / files
    eza # alternative listing to lsd, handy for `eza --tree`
    yazi # TUI file manager

    # system / inspection
    dust # disk usage (du replacement)
    duf # disk free (df replacement)
    procs # process viewer (ps replacement)
    bandwhich # per-process bandwidth
    gping # ping with a graph

    # data / misc
    yq-go # yaml/json/xml processor
    curlie # httpie-like curl frontend
    sd # sed-like find & replace

    # nix workflow
    nix-output-monitor # pretty build output (`nom`)
    alejandra # formatter
    devenv # per-project dev environments (`use devenv` in .envrc)
    nixd

    # Custom wrapper to run games with gamemoderun + mangohud + selected Proton envs.
    # When MOONSHINE_CLIENT_FRAMERATE is present (i.e. the game was launched by
    # Moonshine for a remote client), we skip mangohud and PROTON_ENABLE_WAYLAND
    # because proton + native wayland currently acts bad in moonshine.
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
      )

      if [ -z "''${MOONSHINE_CLIENT_FRAMERATE:-}" ]; then
        ENV+=("PROTON_ENABLE_WAYLAND=1")
        exec gamemoderun mangohud "''${ENV[@]}" "''$@"
      else
        exec gamemoderun env "''${ENV[@]}" "''$@"
      fi
    '')

    # dev stuff
    rustup
    codebook
    marksman
  ];

  # Codebook config
  xdg.configFile."codebook/codebook.toml".text = ''
    ignore_patterns = [
      '\b[A-Z]{3,}\b',
    ]
  '';

  # nh is a nicer frontend for nixos-rebuild + garbage collection. Point it at
  # wherever you keep this flake checked out.
  programs.nh = {
    enable = true;
    flake =
      if isDarwin
      then "/Users/${username}/nixos-dotfiles"
      else "/home/${username}/nixos-dotfiles";
  };
}
