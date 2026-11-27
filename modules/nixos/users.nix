{
  pkgs,
  username,
  local,
  ...
}: {
  # ⇩ username/description come from local.nix.
  users.users.${username} = {
    isNormalUser = true;
    description = local.fullName;
    extraGroups = [
      "wheel" # sudo
      "networkmanager"
      "video"
      "audio"
      "input"
      "gamemode"
      "moonshine"
    ];
    shell = pkgs.fish;
  };

  # fish must be enabled at the system level to be a valid login shell.
  programs.fish.enable = true;

  # Passwordless sudo for the wheel group keeps `nixos-rebuild` snappy. Drop the
  # `wheelNeedsPassword = false` line if you'd rather be prompted.
  security.sudo.wheelNeedsPassword = false;

  # Add main user as trused nix-daemomn user.
  # This use has extra priviliges, like adding binary caches on the fly.
  nix.settings.trusted-users = [username];
}
