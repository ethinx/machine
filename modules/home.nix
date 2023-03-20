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
    ./tmux.nix
  ];

  nixpkgs.overlays = [
    (self: super: {
      python310 = super.python310.override {
        packageOverrides = pyself: pysuper: {
          libtmux = pysuper.libtmux.overridePythonAttrs (_: rec {
            disabledTests = [
              "test_new_session_width_height"
              "test_capture_pane_start"
            ];
            disabledTestPaths = [
              "tests/test_test.py"
              "tests/legacy_api/test_test.py"
            ];
          });
        };
      };
    })
  ];
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
      nodejs-16_x
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
      # ncdu
      coreutils
      gnugrep
      gnused
      gawk
      watch
      wget
      s3cmd
      htop
      ripgrep
      igrep
      lnav
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

      rename
      goreleaser

      you-get
      mediainfo
      tmux
      smug
      ansible
    ] ++ lib.optionals pkgs.stdenvNoCC.isLinux [
      # neovim need tree-sitter, when tree-sitter compile plugins, we need to use gcc in the nixpkgs
      # otherwise may encounter issue 'libstdc++.so.6 Cannot open shared object or file: No such file or directory'
      gcc

      ffmpeg-full
    ] ++ lib.optionals pkgs.stdenvNoCC.isDarwin [
      lima
    ];

  };
}
