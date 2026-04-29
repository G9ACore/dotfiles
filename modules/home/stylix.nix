{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ../../assets/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sizes = {
        terminal = 13;
        applications = 11;
        desktop = 11;
        popups = 11;
      };
    };

    cursor = {
      package = pkgs.catppuccin-cursors.mochaBlue;
      name = "catppuccin-mocha-blue-cursors";
      size = 24;
    };

    # Что красить автоматически
    targets = {
      kitty.enable = true;
      fish.enable = true;
      mako.enable = true;
      starship.enable = true;
      gtk.enable = true;
      noctalia-shell.enable = true;
    };
  };
}