{
  lib,
  pkgs,
  isDarwin,
  ...
}: {
  # `nix-shell` / `nix-shell -p` hardcode bash. any-nix-shell re-execs fish
  # inside the ad-hoc environment so we keep our shell, aliases, and prompt.
  home.packages = [pkgs.any-nix-shell];

  programs.fish = {
    enable = true;
    generateCompletions = true;

    # Modern-unix muscle memory: keep the old names, get the new tools.
    # The lsd module also defines ls/ll/la, so force ours to win the merge.
    shellAliases = {
      ls = lib.mkForce "lsd";
      ll = lib.mkForce "lsd -l";
      la = lib.mkForce "lsd -la";
      lt = lib.mkForce "lsd --tree";
      cat = "bat";
      top = "btop";
      du = "dust";
      df = "duf";
      ps = "procs";
      ping = "gping";
      g = "git";
      lg = "lazygit";

      # nh-powered rebuilds from anywhere.
      rebuild =
        if isDarwin
        then "nh darwin switch"
        else "nh os switch";
      update =
        if isDarwin
        then "nh darwin switch --update"
        else "nh os switch --update";
    };

    interactiveShellInit = ''
      set -g fish_greeting ""

      # Keep fish inside `nix-shell` instead of falling back to bash.
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };
}
