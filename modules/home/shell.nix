{ lib, ... }:
{
  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    settings = lib.importTOML ./config/starship/starship.toml;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
