{
  description = "Nix and home-manager configurations for Jon Dion laptop";
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
    };
  };
  outputs = { darwin, home-manager, nur, nixpkgs, nvim, ... }:
    let
      homeManagerConfFor = config: { ... }: {
        nixpkgs.overlays = [ nur.overlay ];
        imports = [ config ];
      };
      darwinSystem = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.users.jondion = homeManagerConfFor ./home.nix;
            home-manager.extraSpecialArgs = { inherit nvim; };
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };
    in
    {
      darwinConfigurations.myMacbook = darwinSystem;
    };
}
