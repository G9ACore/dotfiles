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

  # Иконки — не шрифты: темы иконок должны быть в systemPackages,
  # чтобы их видел GTK/tray-хост dms-shell (hicolor обязателен как базовый
  # fallback, librsvg нужен для SVG-иконок приложений в трее).
  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    hicolor-icon-theme
    librsvg
  ];
}
