{ pkgs, nix, nixpkgs, config, lib, ... }:

{
  environment.systemPackages = with pkgs;
    [
      home-manager
    ];

  /* fonts = { */
  /*   fontDir.enable = true; */
  /*   fonts = with pkgs; [ */
  /*     hack */
  /*   ]; */
  /* }; */

  system.stateVersion = 4;

  users = {
    users.jondion = {
      home = /Users/jondion;
    };
  };
  nix = {
    nixPath = lib.mkForce [
      "nixpkgs=${nixpkgs}"
    ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    distributedBuilds = false;
  };
  services.nix-daemon.enable = true;
}
