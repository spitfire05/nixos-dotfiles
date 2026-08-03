{local, ...}: {
  # Host-specific hardware config lives here. For common config, see `modules/nixos/hardware.nix`.

  imports = [
    ./hardware-configuration.nix
  ];

  # NVIDIA driver
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

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

  # EDIT ME: edit external filesystems to match your system (if any)
  fileSystems."/mnt/dev" = {
    device = "/dev/disk/by-uuid/44017c53-9dae-4986-b882-e04018d5a878";
    fsType = "btrfs";
    options = ["ssd" "noatime" "nofail"];
  };
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/94e72055-1af0-4ef3-94bb-023077131a8f";
    fsType = "btrfs";
    options = ["ssd" "noatime" "nofail"];
  };

  # The release this config was written against. Do NOT bump casually after
  # first install — read the NixOS release notes first.
  system.stateVersion = "25.05";
}
