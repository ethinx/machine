{
  description = "Nix flake configuration for personal machines";

  nixConfig = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    trusted-substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
  };

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell.url = "github:numtide/devshell";

    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, darwin, flake-utils, ... }@inputs:
    let
      inherit (flake-utils.lib) eachDefaultSystem eachSystem;
    in
    {
      darwinConfigurations.macos-amd64 = import ./darwin {
        inherit inputs nixpkgs nixpkgs-unstable home-manager darwin;
        system = "x86_64-darwin";
        username = "ethinx";
      };

      darwinConfigurations.macos-arm64 = import ./darwin {
        inherit inputs nixpkgs nixpkgs-unstable home-manager darwin;
        system = "aarch64-darwin";
        username = "ethinx";
      };

      homeConfigurations.linux-arm64 = home-manager.lib.homeManagerConfiguration rec {
        system = "aarch64-linux";
        username = "ethinx";
        homeDirectory = "/home/${username}";
        extraSpecialArgs = { inherit inputs nixpkgs system username; };

        configuration = {
          imports = [
            ./modules/home-manager.nix
            ./modules/shell.nix
            ./modules/home.nix
          ];
        };
      };
    };
}
