{...}: {
  nix.settings.extra-substituters = [
    "https://niri-epireyn.cachix.org"
    "https://noctalia.cachix.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    "michal-pc:BsVxUjRRbY8tqDVvvLgjtU1/xGODxp/f9fFqfmsnlxs="
  ];
}
