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
      plugin = {
        prepend_previewers = [
          {
            url = "*.md";
            run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"'';
          }
        ];
        prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
      };
    };

    plugins = with pkgs.yaziPlugins; {
      starship = {
        package = starship;
        setup = true;
      };
      piper = {
        package = piper;
      };
      git = {
        package = git;
        setup = true;
      };
    };
  };
}
