{
  config,
  pkgs,
  ...
}: {
  services = {
    v2raya = {
      enable = true;
      cliPackage = pkgs.xray;
    };
  };

  systemd.services.v2raya.path = with pkgs; [
    kmod
    iptables # На всякий случай, если v2rayA использует классический iptables для роутинга
  ];

  boot.kernelModules = [
    "xt_TPROXY"
    "xt_mark" # Также часто требуется для маркировки пакетов
  ];
}
