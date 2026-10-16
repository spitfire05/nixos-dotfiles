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

    settings = {
      plugin.prepend_previewers = [
        {
          url = "*.md";
          run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"'';
        }
      ];
    };

    plugins = with pkgs.yaziPlugins; {
      starship = {
        package = starship;
        setup = true;
      };
      piper = {
        package = piper;
      };
    };
  };
}
