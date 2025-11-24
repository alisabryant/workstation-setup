{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    
    # Define your preferences declaratively
    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = "Rosé Pine";
        "workbench.iconTheme" = "material-icon-theme";
        "editor.fontFamily" = "'FiraCode Nerd Font Mono', 'Menlo', 'Monaco', 'Courier New', monospace";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "files.autoSave" = "onFocusChange";
        "editor.minimap.enabled" = true;
        "workbench.sideBar.location" = "right";
        "editor.rulers" = [ 80 120 ];
        "terminal.integrated.fontFamily" = "'FiraCode Nerd Font Mono'";
      };

      extensions = with pkgs.vscode-extensions; [
        # Core
        bierner.markdown-mermaid
        eamodio.gitlens
        github.vscode-pull-request-github
        github.vscode-github-actions
        Google.gemini-cli-vscode-ide-companion
        
        # Languages
        ms-python.python
        ms-python.debugpy
        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-maven
        vscjava.vscode-gradle
        graphql.vscode-graphql-syntax
        llvm-vs-code-extensions.vscode-clangd
        
        # Utils
        esbenp.prettier-vscode
        redhat.vscode-yaml
        # vitest.explorer # Not found in nixpkgs
        
        # Theme (If available in your channel, otherwise script installs it)
        # pkgs.vscode-extensions.mvllow.rose-pine 
      ];
    };
  };

  home.file."Library/Application Support/VSCodium/User/tasks.json".text = ''
    {
      "version": "2.0.0",
      "tasks": [
        {
          "label": "Start Gemini CLI",
          "type": "shell",
          "command": "${pkgs.gemini-cli}/bin/gemini",
          "runOptions": {
            "runOn": "folderOpen"
          },
          "presentation": {
            "reveal": "always",
            "panel": "new"
          }
        }
      ]
    }
  '';
}