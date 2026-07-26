{ ... }:
{
  users = {
    users.main = {
      group = "main";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
    mutableUsers = false;
    groups.main = {};
  };
}
