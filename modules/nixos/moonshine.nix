{
  config,
  username,
  ...
}: {
  # Moonshine game streaming server (Moonlight protocol) for LAN/VPN.
  # Uses the NixOS module now shipped in nixpkgs (no external flake needed).
  services.moonshine = {
    enable = true;

    # Stream applications from this user's session (e.g. their Steam library).
    user = username;

    # Everything from the Configuration section of the main README goes
    # here, written as nix instead of TOML.
    settings = {
      name = config.networking.hostName;
      application = [
        {
          title = "Steam";
          command = [
            "/run/current-system/sw/bin/steam"
            "steam://open/bigpicture"
          ];
          pre_command = [
            [
              "/run/current-system/sw/bin/bash"
              "-c"
              "if pgrep -x steam >/dev/null; then /run/current-system/sw/bin/steam -shutdown &>/dev/null; for i in $(seq 1 30); do ! pgrep -x steam >/dev/null && break; sleep 1; done; fi"
            ]
          ];
        }
      ];
    };
  };

  # Open the standard GameStream/Moonlight ports globally.
  # Only do this on a LAN or VPN-facing firewall (we are).
  networking.firewall.allowedTCPPorts = [
    47984 # HTTPS / pairing + web UI
    47989 # HTTP
    48010 # RTSP / stream
  ];
  networking.firewall.allowedUDPPorts = [
    47998 # video
    47999 # control
    48000 # audio
  ];
}
