{pkgs, ...}: {
  # One palette to rule them all. Stylix derives colors for niri, noctalia,
  # foot, bat, btop, helix, GTK/Qt and more from a single base16 scheme.
  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";

    image = ../../themes/wallpaper.webp;

    # A hint of terminal transparency for that layered desktop look.
    # 0.95 looks good for pure transparency
    # 0.85 with blur enabled in WM
    opacity.terminal = 0.85;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "Jetbrains Mono NF";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 12;
        applications = 11;
        desktop = 11;
        popups = 11;
      };
    };
  };
}
