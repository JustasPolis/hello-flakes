{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      config = nixpkgs.config;
    in {
      packages.${system}.default = (import ./default.nix { inherit pkgs; });
      nixosModules.hello = (import ./module.nix { inherit lib config pkgs; });
    };
}
