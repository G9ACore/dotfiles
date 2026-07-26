{ ... }:
{
  users = {
    users.dmitry = {
      group = "main";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
    mutableUsers = false;
    groups.main = {};
  };
}
