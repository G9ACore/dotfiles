{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter
      noto-fonts
      noto-fonts-color-emoji
      colloid-icon-theme
      papirus-icon-theme
      hicolor-icon-theme
      adwaita-icon-theme
    ];

    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font Mono"];
      sansSerif = ["Inter"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
