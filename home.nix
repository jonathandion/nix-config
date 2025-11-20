{
  config,
  lib,
  pkgs,
  nvim,
  system,
  ...
}: {
  imports = import ./programs;

  nixpkgs.overlays = [];

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
      moreutils
      nvim
      renameutils
      gnupg
      fd
      fx
      neovim
      ranger
      ripgrep
      tldr
      tree
      wget
      pstree
      httpie
      devbox
    ];
  };

  programs = {
    home-manager = {enable = true;};

    htop = {enable = true;};

    jq = {enable = true;};

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
      autosuggestion.enable = true; 
      syntaxHighlighting.enable = true;
      initContent = lib.mkBefore ''
        # Fig pre block. Keep at the top of this file.
        [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

        bindkey ^E edit-command-line

        # Fig post block. Keep at the bottom of this file.
        [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi

        export PATH=$HOME/.npm-packages/bin:$PATH

        eval "$(devbox global shellenv --init-hook)"
      '';
      shellAliases = {
        ".f" = "cd $HOME/code/nix-config";
        bulkrename = "qmv -f do";
        cat = "bat";
        dc = "cd $HOME/documents";
        dl = "cd $HOME/downloads";
        dt = "cd $HOME/desktop";
        fm = "vim +Explore";
        ipinfo = "curl ipinfo.io";
        j = "z";
        l = "ls -lFh";
        lS = "ls -1FSsh";
        sdb = "/Users/jondion/tizen-studio/tools/sdb";
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
      settings = {
        user = {
          name = "jonathandion";
          email = "jonathandionalary@gmail.com";
        };
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
