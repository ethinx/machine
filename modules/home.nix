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
      tokei
      tree
      pstree
      ncdu
      gnugrep
      gnused
      gawk
      watch
      wget
      ripgrep
      nmap
      mdbook
      manix
      difftastic

      nixpkgs-fmt

      lima
      vagrant
      podman
      qemu
      kube3d

      chezmoi # dotfile manager
    ];

  };
}
