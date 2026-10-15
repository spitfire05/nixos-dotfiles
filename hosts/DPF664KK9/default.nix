{
  local,
  pkgs,
  wsl,
  ...
}: {
  # Host-specific hardware config lives here. For common config, see `modules/nixos/hardware.nix`.

  imports = [
    # ./hardware-configuration.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "${local.username}";
  
  networking.hostName = local.hostName;

  # ⇩ Timezone comes from local.nix; locale/keyboard layout below.
  time.timeZone = local.timeZone;
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
    # options = "grp:alt_shift_toggle"; # Alt+Shift switches US <-> Russian
  };
  console.keyMap = "pl2";

  security.pki.certificateFiles = [
    ./zscaler_root_ca.crt
    ./sectigo-ca.crt
  ];

  # The release this config was written against. Do NOT bump casually after
  # first install — read the NixOS release notes first.
  system.stateVersion = "25.05";
}
