{
  # ~/dotfiles/lib/theme.nix
  # Единственный источник правды для палитры/шрифтов.
  # Импортируй в любом модуле: theme = import ../../lib/theme.nix;
  # и используй theme.colors.primary вместо хардкода "#b0c6ff".
  #
  # ВАЖНО: CSS/TOML/KDL-файлы (waybar, alacritty, starship, niri) всё равно
  # не смогут читать этот .nix напрямую — они не Nix-код. Но хотя бы все
  # *.nix-модули (obsidian.nix, будущие модули) перестанут хардкодить свои
  # копии хекс-кодов. Для CSS/TOML/KDL храни канонический colors.css и просто
  # не забывай при смене палитры пройтись по всем местам разом grep'ом:
  #   grep -rln "#b0c6ff\|#A1B2C3\|<старый_цвет>" modules/

  colors = {
    background = "#121318";
    surface = "#121318";
    surfaceContainer = "#1e1f25";
    surfaceContainerHigh = "#282a2f";
    onSurface = "#e2e2e9";
    onSurfaceVariant = "#c5c6d0";
    outline = "#8f9099";
    primary = "#b0c6ff";
    primaryContainer = "#2e4578";
    secondary = "#c0c6dc";
    secondaryContainer = "#404659";
    error = "#ffb4ab";
    tertiary = "#e0bbde";
  };

  fonts = {
    monospace = "JetBrainsMono Nerd Font Mono";
    sansSerif = "Inter";
  };
}
