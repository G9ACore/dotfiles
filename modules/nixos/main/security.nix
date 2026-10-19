{
  inputs,
  pkgs,
  settings,
  ...
}: {
  environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];

  # Пароль нужен всегда: NOPASSWD-исключения — только для явного whitelist ниже.
  security.sudo.wheelNeedsPassword = true;

  # Whitelist: пользователю разрешены ТОЛЬКО эти команды без пароля
  # (нужно для кнопок выключения/перезагрузки в wlogout).
  # Пути абсолютные и канонические для NixOS (/run/current-system — symlink на
  # активную генерацию, поэтому переживает nixos-rebuild).
  security.sudo.extraRules = [
    {
      users = [settings.primaryUser];
      runAs = "root";
      commands = [
        {
          command = "${pkgs.systemd}/bin/systemctl poweroff";
          options = ["NOPASSWD"];
        }
        {
          command = "${pkgs.systemd}/bin/systemctl reboot";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # Polkit — авторизация GUI приложений
  security.polkit.enable = true;

  # Разрешаем монтирование без пароля через polkit
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.freedesktop.udisks2.") === 0 &&
          subject.isInGroup("users")) {
        return polkit.Result.YES;
      }
    });
  '';

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
