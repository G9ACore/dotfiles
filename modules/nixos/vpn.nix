{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.agenix.nixosModules.default ];

  age.secrets.amneziawg = {
    file = ../../secrets/amneziawg.age;
    owner = "root";
    mode = "0600";
  };

  environment.systemPackages = [
    inputs.amneziawg-go.packages.${pkgs.system}.default
  ];

  systemd.services.amneziawg = {
    description = "AmneziaWG VPN";
    after = [ "network.target" ];
    wantedBy = [ ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${inputs.amneziawg-go.packages.${pkgs.system}.default}/bin/awg-quick up ${config.age.secrets.amneziawg.path}";
      ExecStop = "${inputs.amneziawg-go.packages.${pkgs.system}.default}/bin/awg-quick down ${config.age.secrets.amneziawg.path}";
    };
  };
}