{ ... }:
{
  users = {
    users.main = {
      group = "main";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    mutableUsers = false;
    groups.main = {};
  };
}
