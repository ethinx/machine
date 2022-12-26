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
      nix-index

      fish
      z-lua
      fzf
      neofetch
      gettext

      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      go_1_19
      goreleaser
      lua
      nodejs
      yarn
      pdm
      # nodePackages.gatsby-cli
      # nodePackages.node-gyp-build

      rustup
      pkg-config
      openssl
      cfssl

      kitty
      git
      bfg-repo-cleaner
      git-crypt
      lazygit
      neovim

      cmake
      ctags
      cscope

      tldr
      gh
      act
      jq
      bat
      xclip
      tokei
      tree
      pstree
      ncdu
      coreutils
      gnugrep
      gnused
      gawk
      watch
      wget
      s3cmd
      htop
      ripgrep
      nmap
      mdbook
      manix
      difftastic
      stylua
      graphviz

      grpcurl
      websocat
      k6

      nixpkgs-fmt
      node2nix

      lima
      vagrant
      podman
      qemu
      kube3d
      k3sup
      kubernetes-helm
      chart-testing
      kind
      kubectl
      awscli
      azure-cli

      chezmoi # dotfile manager
      wireguard-tools
      wireguard-go

      terraform
      packer
      cdrtools # for libvirt provider
      aria
      cabextract
      wimlib
      chntpw
    ] ++ lib.optionals pkgs.stdenvNoCC.isLinux [
      # neovim need tree-sitter, when tree-sitter compile plugins, we need to use gcc in the nixpkgs
      # otherwise may encounter issue 'libstdc++.so.6 Cannot open shared object or file: No such file or directory'
      gcc
      tmux
      ansible
    ];

  };
}
