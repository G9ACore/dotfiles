{ pkgs, lib, ... }:
{
  # Alacritty — терминал
  programs.alacritty = {
    enable = true;
  };
  
  programs.starship = {
    enable = true;
    settings = lib.importTOML ./config/starship/starship.toml;
  };

  xdg.configFile."alacritty/alacritty.toml".source =
    lib.mkForce ./config/alacritty/alacritty.toml;
}
