{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    prismlauncher

    temurin-bin-21 # Minecraft 1.21+
  ];
}
