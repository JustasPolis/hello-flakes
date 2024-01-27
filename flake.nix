{
  description = "GNU hello flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    hello.url = "github:JustasPolis/hello-flakes/main";
  };
  outputs = { self, nixpkgs, hello }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = (import ./derivation.nix { inherit pkgs; });
      nixosModules.default = (import ./module.nix { inherit inputs; });
    };
}
