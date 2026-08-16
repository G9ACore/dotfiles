{
  pkgs,
  lib,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"

      "obsidian"

      "unrar"

      "nvidia-x11"
      "nvidia-settings"
      "nvidia-kernel-modules"

      "teamspeak6-client"
      "teamspeak-server"
      "teamviewer"
    ];
}
