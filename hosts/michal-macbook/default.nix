{local, ...}: {
  # Host-specific hardware config lives here. For common config, see `modules/nixos/hardware.nix`.

  networking.hostName = local.hostName;

  # ⇩ Timezone comes from local.nix; locale/keyboard layout below.
  time.timeZone = local.timeZone;
   
  # The release this config was written against. Do NOT bump casually after
  # first install — read the NixOS release notes first.
  system.stateVersion = 6;
}
