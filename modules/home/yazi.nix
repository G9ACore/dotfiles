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

      preview = {
        image_preview_method = "chafa";
      };
    };
  };

  home.packages = with pkgs; [
    chafa
  ];

  home.sessionVariables = {
    CHAFA_FORMAT = "symbols"; # или "sixels", если терминал частично его переваривает
  };

  xdg.configFile = {
    "yazi/keymap.toml".source = ./config/yazi/keymap.toml;
  };
}
