{ config, lib, pkgs, nvim, ... }:

{
  imports = (import ./programs);

  nixpkgs.overlays = [ ];

  home = {
    stateVersion = "22.11";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
      RIPGREP_CONFIG_PATH = "${config.home.homeDirectory}/.ripgreprc";
    };

    sessionPath = [
      "${config.home.homeDirectory}/bin"
    ];

    packages = with pkgs; [
      asciinema
      awscli2
      bat
      coreutils
      direnv
      fd
      fzf
      gh
      htop
      jq
      lua
      neovim
      nodejs
      python3
      ranger
      renameutils
      ripgrep
      shellcheck
      tldr
      tree
      wget
    ];
  };

  programs = {
    home-manager = { enable = true; };

    bash = {
      enable = true;
      enableCompletion = false;
      shellAliases = {
        ".f" = "cd $HOME/code/nix-config";
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
    };

    zsh = {
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

        # Fig post block. Keep at the bottom of this file.
        [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
      '';
      shellAliases = config.programs.bash.shellAliases;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "z"
          "vi-mode"
        ];
        theme = "zen";
        custom = "${config.xdg.configHome}/zsh";
      };
    };

    git = {
      enable = true;
      userName = "jonathandion";
      userEmail = "jonathandionalary@gmail.com";
      extraConfig = {
        pull = {
          rebase = true;
        };
      };
      ignores = [
        "*~"
        ".DS_Store"
        ".icloud"
        "result"
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --hidden -E .git --no-ignore-vcs --follow --type f";
    };

    gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
      };
    };

    bat = { enable = true; };

    htop = { enable = true; };

    jq = { enable = true; };
  };

  home.file.".ripgreprc".text = ''
    --glob=!git/*
    --hidden
    --follow
  '';

  home.file."bin" = {
    source = ./bin;
    recursive = true;
  };

  xdg.configFile."zsh" = {
    source = programs/zsh;
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = nvim.defaultPackage.aarch64-darwin;
    recursive = true;
  };

  xdg.configFile."hammerspoon" = {
    source = programs/hammerspoon;
    recursive = true;
  };

  xdg.configFile."ranger" = {
    source = programs/ranger;
    recursive = true;
  };
}
