{
  pkgs,
  settings,
  ...
}: {
  users = {
    users.${settings.primaryUser} = {
      group = "main";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];

      shell = pkgs.fish;

      hashedPassword = "$6$.JkZ1o1BdUJmYDlJ$kxmgoLH5PiJJtDqxwH1PVJ7X1LN7JhoFGRsHLqKeEJ/uWLcPnbGua5vUNnImZi3KXbSRRHmEE3nZtkGFZVVJV0";
    };
    mutableUsers = false;
    groups.main = {};
  };
}
