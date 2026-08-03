{
    pkgs,
      username,
        local,
          ...
          }: {
 system.primaryUser = username; # needed on recent nix-darwin

   users.users.${username} = {
         home = "/Users/${username}";
             description = local.fullName;
                 shell = pkgs.fish;
                   };

                     programs.fish.enable = true;

                         security.sudo.extraConfig = ''
                           %admin ALL=(ALL) NOPASSWD: ALL
   '';
}
