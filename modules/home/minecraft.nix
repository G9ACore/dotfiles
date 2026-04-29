{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    prismlauncher

    # Java — нужны разные версии для разных версий Minecraft
    temurin-bin-8    # Minecraft 1.0 – 1.16
    temurin-bin-17   # Minecraft 1.17 – 1.20
    temurin-bin-21   # Minecraft 1.21+
  ];
}