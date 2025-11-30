{ pkgs, userSettings, ... }: {
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # CLI Tools
    coreutils
    curl
    wget
    git
    jq
    grc
    autojump
    pstree
    openbao
    dockutil
    ripgrep
    fd
    fzf
    lazygit
    gh
    (python3.withPackages (ps: with ps; [
      pip
      requests
      pandas
      pyyaml
      ipykernel
    ]))
    mise
    direnv
    gemini-cli
    nodePackages.typescript
    nodejs
    just
    zoxide
    eza
    lazydocker
    btop
    fastfetch
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      lg = "lazygit";
      ll = "ls -alF";
      g = "git";
    };
    initContent = ''
      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
      
      # Source custom functions
      source ${./functions.zsh}

      # Transient Prompt
      setopt PROMPT_SP
      export STARSHIP_TRANSIENT_PROMPT=true
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      # Rosé Pine theme colors
      palette = "rosepine";
      
      scan_timeout = 10;
      
      format = "$username$hostname$directory$git_branch$git_status$character";
      
      palettes.rosepine = {
        base = "#191724";
        surface = "#1f1d2e";
        overlay = "#26233a";
        muted = "#6e6a86";
        subtle = "#908caa";
        text = "#e0def4";
        love = "#eb6f92";
        gold = "#f6c177";
        rose = "#ebbcba";
        pine = "#31748f";
        foam = "#9ccfd8";
        iris = "#c4a7e7";
        highlight_low = "#21202e";
        highlight_med = "#403d52";
        highlight_high = "#524f67";
      };

      username = {
        style_user = "bold love";
        style_root = "bold love";
        format = "[$user]($style)";
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "[@$hostname]($style):";
        style = "bold love";
      };

      character = {
        success_symbol = "[>](bold foam)";
        error_symbol = "[>](bold love)";
      };

      directory = {
        style = "bold gold";
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style) ";
      };

      git_branch = {
        symbol = " ";
        style = "bold pine";
      };

      git_status = {
        style = "bold rose";
        conflicted = "🏳";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[++($count)](foam)";
        renamed = "👅";
        deleted = "🗑";
      };

      nodejs = {
        symbol = " ";
        style = "bold foam";
      };

      python = {
        symbol = " ";
        style = "bold gold";
      };

      rust = {
        symbol = " ";
        style = "bold love";
      };

      package = {
        symbol = "📦 ";
        style = "bold rose";
      };

      # Cloud Context
      aws = {
        symbol = "☁️  ";
        style = "bold gold";
      };

      gcloud = {
        symbol = "🇬️  ";
        style = "bold foam";
      };

      azure = {
        symbol = "🇦️  ";
        style = "bold iris";
      };

      kubernetes = {
        symbol = "⎈ ";
        style = "bold iris";
      };

      docker_context = {
        symbol = "🐳 ";
        style = "bold foam";
      };

      # Telemetry
      cmd_duration = {
        min_time = 2000;
        style = "bold yellow";
      };

      battery = {
        full_symbol = "🔋 ";
        charging_symbol = "⚡️ ";
        discharging_symbol = "💀 ";
        display = [
          { threshold = 10; style = "bold red"; }
        ];
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = userSettings.gitName;
      user.email = userSettings.email;
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "vim";
      credential.helper = "osxkeychain";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # AeroSpace window manager configuration
  home.file.".aerospace.toml".source = ./aerospace.toml;
}