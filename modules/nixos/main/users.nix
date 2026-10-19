{
  pkgs,
  settings,
  config,
  ...
}: {
  users = {
    users.${settings.primaryUser} = {
      group = "main";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "input"];
      shell = pkgs.fish;
      # В секрете лежит ХЕШ пароля (argon2/sha512), а не сам пароль,
      # поэтому используем hashedPasswordFile (а не passwordFile).
      hashedPasswordFile = config.age.secrets.dmitry-password.path;
    };
    mutableUsers = false;
    groups.main = {};
  };
}
