{ ... }:
{
  programs.yazi = {
    enable = true;
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
  # xdg.configFile."yazi/yazi.toml".source = ./config/yazi/yazi.toml;
}
