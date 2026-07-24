{ inputs, lib, system }:
{ hostname, users }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    ../hosts/${hostname}/default.nix

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
