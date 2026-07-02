{
  description = "NixOS config with flakes, niri, home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    mkHost = import ./lib/mkHost.nix { inherit inputs lib system; };
  in {
    nixosConfigurations = {
      laptop = mkHost {
        hostname = "laptop";
        users = [ "main" ];
      };
      vm = mkHost {
        hostname = "vm";
        users = [ "main" ];
      };
    };
  };
}