{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = "${pkgs.fish}/bin/fish";
      window.padding = {
        x = 12;
        y = 12;
      };
    };
  };
}
