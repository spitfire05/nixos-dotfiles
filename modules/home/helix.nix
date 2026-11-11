{...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      keys.normal = {
        C-y = [
          ":sh rm -f /tmp/unique-file"
          ":insert-output yazi \"%{buffer_name}\" --chooser-file=/tmp/unique-file"
          ":sh printf \"\x1b[?1049h\x1b[?2004h\" > /dev/tty"
          ":open %sh{cat /tmp/unique-file}"
          ":redraw"
        ];
        C-g = [
          ":write-all"
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
          ":reload-all"
        ];
        space = {
          q = ":q";
          Q = ":q!";
          x = ":bc";
          X = ":bc!";
        };
      };
      editor = {
        bufferline = "multiple";
        end-of-line-diagnostics = "hint";
        line-number = "relative";
        soft-wrap = {
          enable = true;
        };
        inline-diagnostics = {
          cursor-line = "warning";
        };
        lsp = {
          display-inlay-hints = true;
        };
      };
    };
    languages = {
      language-server = {
        codebook = {
          command = "codebook-lsp";
          args = ["serve"];
        };
        rust-analyzer.config.check = {
          command = "clippy";
          extraArgs = ["--" "-Wclippy::pedantic"];
        };
      };
      language = [
        {
          name = "markdown";
          language-servers = ["marksman" "codebook"];
        }
        {
          name = "c-sharp";
          auto-format = true;
          language-servers = ["csharp-ls"];
        }
        {
          name = "haskell";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nix";
            args = ["fmt"];
          };
        }
      ];
    };
  };
}
