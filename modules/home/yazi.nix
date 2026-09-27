{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
  };

  xdg.configFile = {
    "yazi/keymap.toml".source = ./config/yazi/keymap.toml;
    "yazi/yazi.toml".source = ./config/yazi/yazi.toml;
  };
}
