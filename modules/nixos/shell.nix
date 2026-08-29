{config, ...}: let
  render = import ../../lib/mkTemplate.nix;
  c = config.lib.stylix.colors.withHashtag;
in {
  programs.fish.enable = true;

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (render ../home/config/starship/starship.toml {
      base01 = c.base01;
      base02 = c.base02;
      base03 = c.base03;
      base04 = c.base04;
      base05 = c.base05;
      base08 = c.base08;
      base0A = c.base0A;
      base0D = c.base0D;
      base0E = c.base0E;
    });
  };
}
