{ pkgs, inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;

    # Наша base16-схема, собранная из палитры colors.css (см. base16-matugen.yaml)
    base16Scheme = ../../assets/base16-matugen.yaml;

    # Опционально: если когда-нибудь захочешь пересобирать всю систему под
    # обои через matugen/wallust, можно заменить base16Scheme на:
    # stylix.image = ./wallpapers/current.png;
    # но тогда waybar/alacritty могут разъехаться с остальной темой —
    # проще один раз сгенерировать base16 из финальной Matugen-палитры.

    image = ../../assets/wallpapers/wallpaper.jpg; # обои — используются также swaybg-модулем

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
        applications = 11;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    opacity = {
      terminal = 0.92;
      popups = 0.92;
      desktop = 1.0;
    };
  };
}
