{
  description = "GNU hello flake";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      package = self.packages.${system}.default;
    in {
      packages.${system}.default =
        (import ./derivation.nix { inherit pkgs; }).helloPkg;
      nixosModules.default = (import ./module.nix { inherit inputs self; });
    };
}
