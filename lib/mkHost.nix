{
  inputs,
  lib,
  system,
}: {
  hostname,
  users,
  extraOverlays ? [],
  extraModules ? [],
}: let
  settings = import ./settings.nix;
  terminals = import ./terminals.nix;
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs settings terminals;
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
          backupFileExtension = "backup";
          extraSpecialArgs = {inherit inputs settings terminals;};
          users = lib.genAttrs users (user: import ../users/${user}.nix);
	  sharedModules = extraModules;
        };

        nixpkgs.overlays = extraOverlays;
      }
    ];
  }
