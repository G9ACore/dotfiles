{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    settings = {
      opener = {
        edit = [
          {
            block = true;
            run = "nvim \"$@\"";
          }
        ];
      };
    };
  };

  xdg.configFile = {
    "yazi/keymap.toml".source = ./config/yazi/keymap.toml;
  };
}
