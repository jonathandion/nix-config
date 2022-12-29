{ pkgs, nix, nixpkgs, config, lib, ... }:

{
  environment.systemPackages = with pkgs;
    [
      home-manager
    ];

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      hack-font
    ];
  };

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

  homebrew = {
    enable = true;
    casks = [
      "brave-browser"
      "google-chrome"
      "hammerspoon"
      "insomnia"
      "raycast"
      "stats"
    ];
  };

  services.nix-daemon.enable = true;

  system.stateVersion = 4;

  # macOS specific options
  system.defaults.LaunchServices.LSQuarantine = false;
  system.defaults.trackpad.Clicking = true;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-time-modifier = 0.3;
  system.defaults.dock.expose-animation-duration = 0.3;
  system.defaults.dock.show-recents = false;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  system.defaults.screencapture.location = "~/Downloads";
}
