{ pkgs, system, username, ... }:
let
  isDarwin = system: (builtins.elem system pkgs.lib.platforms.darwin);
  homePrefix = system: if isDarwin system then "/Users" else "/home";
in
{
  xdg.enable = true;

  home.stateVersion = "22.11";

  imports = [
    ./shell.nix
    ./git.nix
    ./tmux.nix
  ];

  # nixpkgs.config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
  nixpkgs.config.allowUnfree = true;

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
      # neovim-unwrapped =
      #   let
      #     # https://github.com/NixOS/nixpkgs/issues/229275#issuecomment-1532921108
      #     liblpeg = super.stdenv.mkDerivation
      #       {
      #         pname = "liblpeg";
      #         inherit (super.luajitPackages.lpeg) version meta src;
      #
      #         buildInputs = [ super.luajit ];
      #
      #         buildPhase = ''
      #           sed -i makefile -e "s/CC = gcc/CC = clang/"
      #           sed -i makefile -e "s/-bundle/-dynamiclib/"
      #
      #           make macosx
      #         '';
      #
      #         installPhase = ''
      #           mkdir -p $out/lib
      #           mv lpeg.so $out/lib/lpeg.dylib
      #         '';
      #
      #         nativeBuildInputs = [ super.fixDarwinDylibNames ];
      #       };
      #   in
      #   super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
      #     src = super.fetchFromGitHub {
      #       owner = "neovim";
      #       repo = "neovim";
      #       rev = "b12d193b4a68242fb0c7e4f924c8abce3488e1c8";
      #       sha256 = "sha256-HYjgX66AVMqG6jxl83O8NzZyUkULZJv3PRaXw9jgR1o=";
      #     };
      #     patches = [ ];
      #     nativeBuildInputs = oldAttrs.nativeBuildInputs ++ super.lib.optionals pkgs.stdenvNoCC.isDarwin [
      #       liblpeg
      #       super.libiconv
      #     ];
      #   });
    })
  ];
  home = {
    username = "${username}";
    homeDirectory = "${homePrefix system}/${username}";

    packages = with pkgs; [
      nix-index
      uv

      fish
      z-lua
      fzf
      neofetch
      gettext

      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
      go
      gotools
      goreleaser
      lua
      # nodejs-16_x
      nodejs
      yarn
      # nodePackages.wrangler
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

      gnupg

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
      igrep
      #lnav
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

      # vagrant
      podman
      qemu
      kube3d
      k3sup
      kubernetes-helm
      chart-testing
      kind
      kubectl
      awscli
      #azure-cli

      chezmoi # dotfile manager
      wireguard-tools
      wireguard-go

      terraform
      packer
      cdrtools # for libvirt provider
      aria
      cabextract
      chntpw

      rename
      goreleaser

      you-get
      mediainfo
      tmux
      smug
      # ansible
      # python310Packages.lxml
      # python311Packages.lxml

      restic
      rclone

      ninja
      # pdm
      # onnxruntime
      # python310Full
      # python310Packages.virtualenv
      # python310Packages.onnxruntime
      # python310Packages.pillow
      # python310Packages.opencv3

    ] ++ lib.optionals pkgs.stdenvNoCC.isLinux [
      # neovim need tree-sitter, when tree-sitter compile plugins, we need to use gcc in the nixpkgs
      # otherwise may encounter issue 'libstdc++.so.6 Cannot open shared object or file: No such file or directory'
      gcc

      wimlib # depends on fuse3 and it does not support darwin

      ffmpeg-full
    ] ++ lib.optionals pkgs.stdenvNoCC.isDarwin [
      gnutar
      pandoc
      hugo
      # lima
      # gpredict
    ];

  };
}
