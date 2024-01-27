{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = (import ./default.nix { inherit pkgs; });
      nixosModules.hello = (import ./module.nix { inherit inputs pkgs; });
    };
}
