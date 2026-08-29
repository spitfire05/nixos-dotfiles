{
  description = "nixos-dotfiles — an opinionated NixOS + Niri + Noctalia stack (with Darwin support)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Scrollable-tiling Wayland compositor + NixOS/home-manager modules.
    # Deliberately does NOT follow our nixpkgs, so niri-flake's prebuilt
    # packages stay byte-identical to what niri.cachix.org has cached.
    niri.url = "github:epireyn/niri-flake";

    # Noctalia desktop shell (v5 line). Pinned to the `cachix` branch: upstream
    # force-pushes there only after a commit's package is built and pushed to
    # noctalia.cachix.org, so `packages.default` is guaranteed to be a cache hit
    # (no ~hour-long C++ source build). It tracks `main` (v5), just slightly
    # behind. Crucially we do NOT make it follow our nixpkgs — that would
    # rebuild it against a different nixpkgs and miss the cache.
    noctalia.url = "github:noctalia-dev/noctalia-shell/cachix";

    # System-wide base16 theming.
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen browser (not in nixpkgs). It's a repackaged binary (fixed-output
    # download + wrapFirefox), so following our nixpkgs is cheap and avoids a
    # duplicate nixpkgs in the closure.
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      # Its home-manager module reuses HM's firefox module, so share ours.
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    nixpkgs,
    nix-darwin,
    home-manager,
    niri,
    noctalia,
    stylix,
    ...
  } @ inputs: let
    # Personal, machine-local settings. Tracked with placeholder defaults but
    # marked skip-worktree so your real values never get committed:
    #   git update-index --skip-worktree local.nix
    local = import ./local.nix;
    inherit (local) username;

    # Helper so `nix fmt` / `nix develop` work from macOS or Linux.
    devSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs devSystems;
    pkgsFor = system: nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.michal-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username local;
      };
      modules = [
        niri.nixosModules.niri
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager

        ./hosts/michal-pc
        ./modules/nixos

        {
          nixpkgs.config.allowUnfree = true;
          # Vesktop builds Vencord with pnpm, which nixpkgs currently marks
          # insecure. It's a build-time tool only; allow it by name so the rule
          # survives pnpm version bumps. (See modules/home/discord.nix.)
          nixpkgs.config.allowInsecurePredicate = pkg: nixpkgs.lib.getName pkg == "pnpm";
          nixpkgs.overlays = [
            niri.overlays.niri
            noctalia.overlays.default
          ];

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.extraSpecialArgs = {
            inherit inputs username local;
            isDarwin = false;
          };
          home-manager.users.${username} = import ./modules/home;
        }
      ];
    };

    darwinConfigurations.michal-macbook = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs username local;
      };
      modules = [
        stylix.darwinModules.stylix
        home-manager.darwinModules.home-manager

        ./hosts/michal-macbook
        ./modules/darwin

        {
          nixpkgs.config.allowUnfree = true;

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.extraSpecialArgs = {
            inherit inputs username local;
            isDarwin = true;
          };
          home-manager.users.${username} = import ./modules/home;
        }
      ];
    };

    # `nix fmt`
    formatter = forAllSystems (system: (pkgsFor system).alejandra);

    # `nix develop` — tooling for hacking on this repo.
    devShells = forAllSystems (system: {
      default = (pkgsFor system).mkShell {
        packages = with pkgsFor system; [
          alejandra
          statix
          deadnix
          nh
          nix-output-monitor
          glow
        ];
      };
    });
  };
}
