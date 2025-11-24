{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bierner.markdown-mermaid
      eamodio.gitlens
      github.vscode-pull-request-github
      github.vscode-github-actions
      ms-python.python
      ms-python.debugpy
      redhat.java
      vscjava.vscode-java-debug
      vscjava.vscode-maven
      vscjava.vscode-gradle
      graphql.vscode-graphql-syntax
      llvm-vs-code-extensions.vscode-clangd
      esbenp.prettier-vscode
      redhat.vscode-yaml
      # vitest.explorer # Not found in nixpkgs
    ];
  };
}