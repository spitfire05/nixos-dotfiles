{
  lib,
  isDarwin,
  ...
}: {
  programs.opencode = {
    enable = true;
    settings = lib.mkIf (!isDarwin) {
      model = "ollama/qwen2.5-coder:7b";
      small_model = "ollama/qwen2.5-coder:7b";
    };
  };
}
