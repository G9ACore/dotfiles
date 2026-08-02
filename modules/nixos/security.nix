{ pkgs, inputs, ... }:
{
  environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];

  # Sudo без пароля для wheel (опционально, удобно)
  # security.sudo.wheelNeedsPassword = false;

  # Polkit — авторизация GUI приложений
  # security.polkit.enable = true;

  # Keyring — хранение паролей (нужен для некоторых приложений)
  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.greetd.enableGnomeKeyring = true;

  # Системный SSH
  #services.openssh = {
   # enable = false;  # Включи если нужен удалённый доступ
    #settings.PasswordAuthentication = false;
  # };
}
