{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  ado_host = "DPF664KK9";
in {
  programs.opencode = {
    enable = true;
    settings = {
      plugin = ["@dietrichgebert/ponytail"];
      mcp = lib.optionalAttrs (osConfig.networking.hostName == ado_host) {
        "azure-devops" = {
          "type" = "local";
          "command" = [
            "npx"
            "-y"
            "@azure-devops/mcp"
            "techdatacorp"
          ];
          "enabled" = true;
        };
      };
    };
  };

  # Opencode needs npx for MCP, conditionally enabled for hosts that actually need it atm.
  home.packages = lib.mkIf (osConfig.networking.hostName == ado_host) [pkgs.nodejs];
}
