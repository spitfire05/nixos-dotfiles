{...}: {
  xdg.desktopEntries."moonshine-control-panel" = {
    name = "Moonshine Control Panel";
    genericName = "Control Panel";
    exec = "xdg-open http://localhost:47990";
    type = "Application";
    categories = ["Utility"];
  };
}
