{
  pkgs,
  username,
  local,
  ...
}: {
  # ⇩ username/description come from local.nix.
  users.users.${username} = {
    description = local.fullName;
    shell = pkgs.fish;
  };

  # fish must be enabled at the system level to be a valid login shell.
  programs.fish.enable = true;
}
