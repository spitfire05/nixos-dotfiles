{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    presets = ["bracketed-segments"];
  };
}
