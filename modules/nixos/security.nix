{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [inputs.agenix.packages.x86_64-linux.default];

  security.sudo.extraRules = [
    {
      users = ["dmitry"];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/systemctl poweroff";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/systemctl reboot";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
  # Sudo без пароля для wheel (опционально, удобно)
  # security.sudo.wheelNeedsPassword = false;

  # Polkit — авторизация GUI приложений
  # security.polkit.enable = true;

  # Keyring — хранение паролей (нужен для некоторых приложений)
  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.greetd.enableGnomeKeyring = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false; # только по ключу — важно для безопасности
      PermitRootLogin = "no";
    };
  };
}
