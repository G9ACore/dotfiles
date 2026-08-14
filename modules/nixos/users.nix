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
      hashedPasswordFile = config.age.secrets.dmitry-password.path;
    };
    mutableUsers = false;
    groups.main = {};
  };
}
