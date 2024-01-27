{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      config = self.config;
    in {
      packages.${system}.default = (import ./default.nix { inherit pkgs; });
      nixosModules.hello = (import ./module.nix { inherit lib config pkgs; });
    };
}
