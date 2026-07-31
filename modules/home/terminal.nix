{ pkgs, lib, ... }:
{
  # Kitty — терминал
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      window_padding_width = 8;
      hide_window_decorations = "yes";
      background_opacity = lib.mkForce "0.95";
    };
  };
}
