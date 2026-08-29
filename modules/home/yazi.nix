{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  xdg.configFile = {
    "yazi/keymap.toml".source = ./config/yazi/keymap.toml;
    "yazi/yazi.toml".source = ./config/yazi/yazi.toml;
  };
}
