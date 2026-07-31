{...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      keys.normal.space = {
        q = ":q";
        Q = ":q!";
        x = ":bc";
        X = ":bc!";
        g = [
          ":write-all"
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
          ":reload-all"
        ];
      };
      editor = {
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
          name = "rust";
          language-servers = ["rust-analyzer" "codebook"];
        }
        {
          name = "c-sharp";
          language-servers = ["omnisharp" "codebook"];
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
