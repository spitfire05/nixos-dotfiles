{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    plugins = with pkgs.yaziPlugins; {
      starship = {
        package = starship;
        setup = true;
      };
    };
  };
}
