{
  description = "Nix, home-manager configurations for Jon Dion computer";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = github:nix-community/nur;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim = {
      url = "github:jonathandion/web-dev.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    darwin,
    home-manager,
    nur,
    nixpkgs,
    nvim,
    ...
  }: let
    system = "aarch64-darwin";
    homeManagerConfFor = config: {...}: {
      nixpkgs.overlays = [nur.overlay];
      imports = [config];
    };
    darwinSystem = darwin.lib.darwinSystem {
      system = system;
      modules = [
        ./darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.users.jondion = homeManagerConfFor ./home.nix;
          home-manager.extraSpecialArgs = {
            nvim = nvim.defaultPackage.${system};
          };
        }
      ];
      specialArgs = {inherit nixpkgs;};
    };
  in {
    darwinConfigurations.myMacbook = darwinSystem;
  };
}
