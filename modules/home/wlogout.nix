{ pkgs, ... }:
{
  home.packages = with pkgs; [ wlogout ];
  xdg.configFile."wlogout/layout.json".source = ./config/wlogout/layout.json;
  xdg.configFile."wlogout/style.css".source = ./config/wlogout/style.css;
}
