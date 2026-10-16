{...}: {
  programs.opencode = {
    enable = true;
    settings = {
      plugin = ["@dietrichgebert/ponytail"];
    };
  };
}
