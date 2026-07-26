{
  description = "NixOS config with flakes, niri, home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    mkHost = import ./lib/mkHost.nix { inherit inputs lib system; };
  in {
    nixosConfigurations = {
      laptop = mkHost {
        hostname = "laptop";
        users = [ "dmitry" ];
      };
    };
  };
}
