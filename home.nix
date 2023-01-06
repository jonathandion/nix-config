{ config, lib, pkgs, nvim, system, ... }:

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
      coreutils
      renameutils
      fd
      fx
      neovim
      ranger
      ripgrep
      tldr
      tree
      wget
      pstree
    ];
  };

  programs = {

    home-manager = { enable = true; };

    htop = { enable = true; };

    jq = { enable = true; };

    broot = {
      enable = true;
    };

    bash = {
      enable = true;
      enableCompletion = true;
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
      shellAliases = {
        ".f" = "cd $HOME/code/nix-config";
        bulkrename = "qmv -f do";
        cat = "bat";
        dc = "cd $HOME/documents";
        dl = "cd $HOME/downloads";
        dt = "cd $HOME/desktop";
        fm = "broot";
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
        rld = "exec $SHELL -l";
        v = "nvim";
        vim = "nvim";
        weather = "curl wttr.in/Montreal";
        nd = "nix develop -c $SHELL";
      };
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

    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };

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
    source = nvim;
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
