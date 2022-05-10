{ pkgs, system, username, ... }:
let
  isDarwin = system: (builtins.elem system pkgs.lib.platforms.darwin);
  homePrefix = system: if isDarwin system then "/Users" else "/home";
in
{
  xdg.enable = true;

  imports = [
    ./shell.nix
    ./git.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "${homePrefix system}/${username}";

    packages = with pkgs; [
      fish
      z-lua
      fzf
      neofetch

      go
      nodejs
      yarn

      git
      vim
      neovim

      cmake
      ctags
      cscope

      gh
      jq
      tree
      pstree
      ncdu
      gnugrep
      gnused
      gawk
      watch
      ripgrep
      nmap
      mdbook
      difftastic

      nixpkgs-fmt

      lima
      vagrant

      chezmoi # dotfile manager
    ];

  };
}
