{ inputs, lib, system }:
{ hostname, users }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    # Системные модули
    ../hosts/${hostname}/default.nix
    ../modules/nixos/core.nix
    ../modules/nixos/audio.nix
    ../modules/nixos/network.nix
    ../modules/nixos/niri.nix
    ../modules/nixos/security.nix

    # Stylix на уровне системы
    inputs.stylix.nixosModules.stylix

    # Home Manager встроен в систему
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users = lib.genAttrs users (user: import ./users/${user}.nix);
      };
    }
  ];
}
