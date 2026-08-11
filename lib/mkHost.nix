{
  inputs,
  lib,
  system,
}: {
  hostname,
  users,
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs;
  };
  modules = [
    ../hosts/${hostname}/default.nix

    # The inputs below are integrated into the system
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
        users = lib.genAttrs users (user: import ../users/${user}.nix);
      };

      # TODO: Move obsidian overlay, because mkHost uni for all users
      nixpkgs.overlays = [
        inputs.obsidian-extensions.overlays.default
      ];
    }
  ];
}
