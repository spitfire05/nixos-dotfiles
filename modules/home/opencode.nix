{
  lib,
  isDarwin,
  ...
}: {
  programs.opencode = {
    enable = true;
    settings = lib.mkIf (!isDarwin) {
      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama";
          options = {
            baseURL = "http://127.0.0.1:11434/v1";
            apiKey = "ollama";
          };
          models = {
            "gemma4:e4b" = {
              tools = true;
            };
          };
        };
      };
      model = "ollama/gemma4:e4b";
    };
  };
}
