{
  description = "NixOS config with flakes, niri, home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    obsidian-extensions = {
      url = "github:karaolidis/nix-obsidian-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stylix,
    git-hooks,
    agenix,
    zen-browser,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    lib = nixpkgs.lib;
    mkHost = import ./lib/mkHost.nix {inherit inputs lib system;};
  in {
    checks.${system}.pre-commit-check = git-hooks.lib.${system}.run {
      src = ./.;
      hooks = {
        alejandra.enable = true; # Встроенная поддержка Alejandra
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      inherit (self.checks.${system}.pre-commit-check) shellHook;
      buildInputs = [pkgs.alejandra];
    };

    nixosConfigurations = {
      laptop = mkHost {
        hostname = "laptop";
        users = ["dmitry"];
        extraOverlays = [inputs.obsidian-extensions.overlays.default];
      };
    };
  };
}
