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

  programs.vim = {
    enable = true;
    extraConfig = ''
      set rtp+=~/.vim
      source ~/.vim/vimrc
    '';
    plugins = [ ];
    packageConfigurable = pkgs.vim_configurable.override {
      guiSupport = "no";
    };
    #packageConfigurable = pkgs.vim_configurable.override {
    #  customize = {
    #    vimrcConfig = {
    #      customRC = ''
    #      '';
    #    };
    #  };
    #};
  };

  home = {
    username = "${username}";
    homeDirectory = "${homePrefix system}/${username}";

    packages = with pkgs; [
      fish
      z-lua
      fzf
      neofetch

      go_1_18
      lua
      nodejs
      yarn

      cargo
      pkg-config
      openssl

      git
      lazygit
      neovim

      cmake
      ctags
      cscope

      gh
      act
      jq
      bat
      xclip
      tokei
      tree
      pstree
      ncdu
      gnugrep
      gnused
      gawk
      watch
      wget
      htop
      ripgrep
      nmap
      mdbook
      manix
      difftastic
      stylua

      nixpkgs-fmt

      lima
      vagrant
      podman
      qemu
      kube3d
      kubernetes-helm
      kind
      kubectl

      chezmoi # dotfile manager
      wireguard-tools
      wireguard-go

      terraform
    ];

  };
}
