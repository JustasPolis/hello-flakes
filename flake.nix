{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.packages.${system};
    in {
      packages.${system}.default = (import ./default.nix { inherit pkgs; });
      nixosModules.default = (import ./module.nix { inherit inputs pkgs; });
    };
}
