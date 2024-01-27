{
  description = "GNU hello flake";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };
  outputs = { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = (import ./derivation.nix { inherit pkgs; });
      nixosModules.default = (import ./module.nix { inherit inputs pkgs self; });
    };
}
