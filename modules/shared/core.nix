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
    python3
    mise
    direnv
    gemini-cli
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
    '';
  };

  programs.git = {
    enable = true;
    userName = userSettings.gitName;
    userEmail = userSettings.email;
    extraConfig = {
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
}