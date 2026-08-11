{ config, pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = "gtk";
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
      niri = {
        default = lib.mkForce "gtk";
        "org.freedesktop.impl.portal.FileChooser" = lib.mkForce "termfilechooser";
      };
    };
  };

  systemd.user.services.xdg-document-portal = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecSearchPath = [ "${pkgs.fuse3}/bin" ];
  };

  # Окружение для user-сервисов через NixOS
  systemd.user.settings.Manager = {
    DefaultEnvironment = "WAYLAND_DISPLAY=wayland-1 XDG_CURRENT_DESKTOP=niri";
  };
}
