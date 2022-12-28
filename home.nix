{ config, lib, pkgs, ... }:

{
  programs.home-manager.enable = true;

  /* imports = (import ./programs); */

  nixpkgs.overlays = [ ];

  home = {
    stateVersion = "22.11";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
      RIPGREP_CONFIG_PATH = "${config.home.homeDirectory}/.ripgreprc";
    };

    packages = with pkgs; [
      nodejs
      htop
      python3
      neovim
      lua
      awscli2
      fzf
      tree
      wget
      jq
      gh
      fd
      bat
      ranger
      ripgrep
      direnv
      shellcheck
      coreutils
      renameutils
      asciinema
      tldr
    ];
  };

  programs.bat = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtraFirst = ''
      # Fig pre block. Keep at the top of this file.
      [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
    '';
    initExtra = ''
      bindkey ^E edit-command-line

      export PATH=$PATH:${config.home.homeDirectory}/code/.f/bin

      # Fig post block. Keep at the bottom of this file.
      [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
    '';
    shellAliases = {
      ".f" = "cd $HOME/code/.f";
      bulkrename = "qmv -f do";
      dc = "cd $HOME/documents";
      dl = "cd $HOME/downloads";
      dt = "cd $HOME/desktop";
      fm = "ranger";
      ipinfo = "curl ipinfo.io";
      j = "z";
      l = "ls -lFh";
      lS = "ls -1FSsh";
      la = "ls -lAFh";
      ldot = "ls -ld .*";
      ll = "ls -l";
      lr = "ls -tRFh";
      lrt = "ls -1Fcrt";
      lt = "ls -ltFh";
      map = "xargs -n1";
      oldvim = "vim";
      rld = "exec $SHELL -l";
      v = "vim";
      vi = "nvim";
      vim = "nvim";
      weather = "curl wttr.in/Montreal";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "vi-mode"
      ];
      theme = "zen";
      custom = "${config.home.homeDirectory}/.zsh_custom";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
    };
  };

  programs.htop = {
    enable = true;
  };

  programs.jq = {
    enable = true;
  };

  xdg.configFile."nvim/init.lua".source = programs/neovim/init.lua;
}
