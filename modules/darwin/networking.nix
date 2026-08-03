{local, ...}: {
  networking.networkmanager.enable = true;

  networking.interfaces = {
    enp34s0 = { # This needs to match the ethernet iface name
      wakeOnLan.enable = true;
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      53317 # localsend
    ];
    allowedUDPPorts = [
      9     # WoL
      53317 # localsend
    ];
  };

  # Keep the clock correct over NTP. A skewed clock is the #1 cause of bogus
  # TLS "certificate not valid yet / expired" errors in the browser, since cert
  # validity is checked against system time.
  services.timesyncd.enable = true;

  # Faster name resolution / mDNS for `.local` hosts.
  services.resolved.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      UseDns = true;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ local.username ];
    }
    ;
  };

  services.tailscale.enable = true;
}
