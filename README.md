# nixos-dotfiles

<p align="center">
  <img src="screenshot.png" alt="Screenshot of the NNN desktop — Niri + Noctalia on NixOS" width="100%">
</p>

> My personal, opinionated **NNN** (NixOS + Niri + Noctalia) stack config. Based on [nnn-starter](https://github.com/floatdrop/nnn-starter).

## What is included

| Layer             | Choice                                                                                                                     |
|--------------     |--------                                                                                                                    |
| Compositor        | [niri](https://github.com/YaLTeR/niri) (scrollable-tiling Wayland) via [niri-flake](https://github.com/epireyn/niri-flake) |
| Shell/UI          | [Noctalia](https://github.com/noctalia-dev/noctalia-shell) **v5** (bar, launcher, notifications, lock, control center)     |
| Theming           | [Stylix](https://github.com/nix-community/stylix) with the **Catppuccin Mocha** palette — one scheme themes everything     |
| Terminal          | [Foot](https://codeberg.org/dnkl/foot)                                                                                             |
| Shell + prompt    | Fish + [Starship](https://starship.rs) (autosuggestions, syntax highlighting, fzf, zoxide)                                 |
| Editor (GUI)      | [Zed](https://zed.dev) — themed via Stylix; default handler for text/source files                                          |
| Editor (terminal) | [Helix](https://helix-editor.com/); the `$EDITOR`                                                                          |
| Browser           | [Zen](https://zen-browser.app) (beta channel, via the community flake)                                                     |
| File manager      | [Nautilus](https://apps.gnome.org/Nautilus/) (GNOME Files)                                                                 |
| Font              | Jetbrains Mono NF                                                                                                          |
| Login             | greetd + tuigreet → niri session (autologin, security achieved via root partition encryption, Omarchy-style)               |
| Gaming            | Steam + Proton-GE + Gamemode + Mangohud                                                                                    |

### Modern command-line toolset
`lsd` · `fzf` · `bat` · `btop` · `ripgrep` · `fd` · `zoxide` · `eza` · `yazi` ·
`dust` · `duf` · `procs` · `bandwhich` · `gping` · `zellij` ·
`tealdeer` · `jq` · `yq` · `lazygit` · `delta` · `gh` · `direnv` + `nix-direnv` ·
`nh` · `nom`.
Old names are aliased to the new tools (`ls`→`lsd`, `cat`→`bat`,
`cd`→`zoxide`, `top`→`btop`, …).

## Quick start

```sh
# 1. Get the repo onto your machine (or into the live NixOS installer).
git clone https://github.com/spitfire05/nixos-dotfiles.git ~/nixos-dotfiles
cd ~/nixos-dotfiles

# 2. Generate real hardware config for THIS machine.
sudo nixos-generate-config --show-hardware-config > hosts/<HOSTNAME>/hardware-configuration.nix

# 3. Put your identity in local.nix (see Placeholders below), then keep your
#    edits out of git history:
git update-index --skip-worktree local.nix

# 4. Build & switch. <HOSTNAME> comes from `local.nix` (and must match the key under `nixosConfigurations` or `darwinConfigurations` in `flake.nix`)
sudo nixos-rebuild switch --flake .#<HOSTNAME>
```

For macOS/Darwin hosts use the equivalent `darwin-rebuild` (or the `rebuild` fish alias) after adding a `darwinConfiguration` entry.

After the first build, use the `rebuild` (or `update`) fish alias (maps to `nh os switch` / `nh darwin switch` as appropriate) or `nh` directly.

## Placeholders to edit

Your personal settings live in one place — [`local.nix`](local.nix). It's
tracked with neutral defaults but marked `skip-worktree` (step 3) so your real
values never get staged or committed.

| What                              | Where                                                            |
|------                             |-------                                                           |
| **Username, hostname, full name** | [`local.nix`](local.nix)                                         |
| **Git identity** (name, email)    | [`local.nix`](local.nix)                                         |
| **Timezone**                      | [`local.nix`](local.nix)                                         |
| **Monitor scale**                 | [`local.nix`](local.nix)                                         |
| **Hardware**                      | `hosts/<HOSTNAME>/hardware-configuration.nix` (generated, step 2) |
| **External storage** if any       | `hosts/<HOSTNAME>/default.nix`                                    |
| **Locale / keyboard layout**      | [`hosts/<HOSTNAME>/default.nix`](hosts/<HOSTNAME>/default.nix)    |
| **Monitor name / position**       | `outputs` in [`modules/home/niri.nix`](modules/home/niri.nix)    |

> Editing the defaults themselves (e.g. to change the placeholders this repo
> ships) needs `git update-index --no-skip-worktree local.nix` first.

## Layout

```
flake.nix              # inputs + nixosConfigurations + darwinConfigurations
local.nix              # your machine-local identity (skip-worktree)
hosts/michal-pc/       # Linux host (NVIDIA, mounts, etc.)
hosts/michal-macbook/  # Darwin host
modules/nixos/         # system: boot, audio, niri, noctalia, stylix, users…
modules/home/          # user: fish, foot, helix, niri keybinds, cli tools…
modules/darwin/        # macOS-specific modules
```

GUI/desktop apps and the niri/Noctalia stack are Linux-only (conditional imports in `modules/home/default.nix`).

## Darwin / macOS support

The flake also exports `darwinConfigurations.michal-macbook`.

User configuration is shared via `modules/home`; Linux-only modules (niri, noctalia, foot, zed, media, etc.) are skipped on Darwin.
- Terminal: Alacritty (Foot is Linux-only).
- Rebuild with the `rebuild` fish alias (`nh darwin switch`).
- Use the same `local.nix` (hostName etc. can differ per-machine via skip-worktree).

## Key bindings (niri)

| Keys | Action |
|------|--------|
| `Mod`+`Return` | Terminal |
| `Mod`+`Space` | Noctalia launcher |
| `Mod`+`B` | Browser (Zen) |
| `Mod`+`E` | File manager (Nautilus) |
| `Mod`+`Q` | Close window |
| `Mod`+`O` | Toggle overview |
| `Mod`+`F` / `Mod`+`Shift`+`F` | Maximize column / fullscreen |
| `Mod`+`Left`/`Right`/`Up`/`Down` | Focus column/window |
| `Mod`+`Shift`+`Left`/`Right`/`Up`/`Down` | Move window |
| `Mod`+`1`…`5` | Switch workspace |
| `Mod`+`Alt`+`Up` / `Down` | Switch workspace up / down |
| `Mod`+`R` | Cycle column width |
| `Print` | Screenshot |
| `Mod`+`Shift`+`/` | Hotkey overlay (full list) |
| `Mod`+`Shift`+`E` | Quit niri |
| `Mod`+`L` | Lock session |
| `Mod`+`Shift`+`Ctrl`+`L` | Lock session & suspend |

See `modules/home/niri.nix` for the full current list (arrows, media keys, tabbed, floating, resize, etc.).

## Reskin it

Everything is driven by one base16 file. Swap the palette and rebuild:

```nix
# modules/nixos/stylix.nix
stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
```

## Verifying changes

You can develop this on **macOS**, but a NixOS system can't be *built* there
without a Linux builder — these all work locally as pure evaluation/lint:

```sh
nix flake check                                              # evaluate everything
nix flake show                                               # list outputs
nix fmt                                                      # format (alejandra)
nix run nixpkgs#statix -- check . && nix run nixpkgs#deadnix # lint
nix eval .#nixosConfigurations.michal-pc.config.system.build.toplevel.drvPath
# On macOS: nix build .#darwinConfigurations.michal-macbook.system
```

On a NixOS box (or with a remote/`linux-builder`) you can smoke-test in a VM:

```sh
nixos-rebuild build-vm --flake .#<HOSTNAME>
./result/bin/run-<HOSTNAME>-vm
```

### CI

[`.github/workflows/check.yml`](.github/workflows/check.yml) runs on every push
and PR:

- **eval** — `nix flake check --no-build --all-systems` evaluates the whole config (the fast,
  reliable signal: catches option typos and niri schema errors).
- **lint** — `alejandra --check`, `statix`, `deadnix`.
- **build** — realises the full system closure; runs on `main` / manual
  dispatch. niri and noctalia are pulled prebuilt from their cachix caches
  (`niri-epireyn.cachix.org`, `noctalia.cachix.org`), so it finishes in minutes instead
  of compiling C++/Rust from source. Delete the job if you don't want it.

> **Commit a `flake.lock`.** Generate it once on a machine with Nix
> (`nix flake lock`) and commit it, so CI and your machines resolve identical
> inputs. Until then, each run pins the latest upstream automatically.

## Notes / next steps (not included)

- Secrets: add [sops-nix](https://github.com/Mic92/sops-nix) or
  [agenix](https://github.com/ryantm/agenix).
- Declarative disks: add [disko](https://github.com/nix-community/disko).
- Multi-host: `hosts/michal-pc/` and `hosts/michal-macbook/` exist; add more entries to `flake.nix` as needed.

### Binary caches (no source builds)

niri and noctalia would otherwise compile from source (noctalia's C++ tree alone
is ~an hour). To avoid that, the flake pins **noctalia to its `cachix` branch**
— upstream force-pushes there only after a commit's package is built and pushed
to `noctalia.cachix.org`, so `inputs.noctalia.packages.<sys>.default` is always a
cache hit. It still tracks the **v5 line** (`main`), just slightly behind; the
old series lives on `legacy-v4`. niri uses niri-flake's prebuilt
`niri-stable` from `niri.cachix.org` for the same reason.

The two caches are trusted in [`modules/nixos/default.nix`](modules/nixos/default.nix)
so your machine pulls binaries too. Neither input may `follows` our `nixpkgs` —
that would rebuild them against a different nixpkgs and miss the cache.
