{pkgs, ...}: {
  programs.yazi = {
    enable = true;

    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["g" "r"];
          run = "shell -- ya emit cd \"$(git rev-parse --show-toplevel)\"";
          desc = "Go to git root";
        }
      ];
    };

    plugins = with pkgs.yaziPlugins; {
      starship = {
        package = starship;
        setup = true;
      };
    };
  };
}
