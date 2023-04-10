{
  description = "Nix flake configuration for personal machines";

  nixConfig = {
    trusted-substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
    trusted-users = "root,ethinx";
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
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
      url = "github:nix-community/home-manager/master";
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
      username = "ethinx";
    in
    {
      darwinConfigurations.macos-amd64 = import ./darwin {
        inherit inputs nixpkgs nixpkgs-unstable home-manager darwin username;
        system = "x86_64-darwin";
      };

      darwinConfigurations.macos-arm64 = import ./darwin {
        inherit inputs nixpkgs nixpkgs-unstable home-manager darwin username;
        system = "aarch64-darwin";
      };

      homeConfigurations.linux-arm64 = home-manager.lib.homeManagerConfiguration rec {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = { inherit inputs nixpkgs username; } // { system = "aarch64-linux"; };
        modules = [
          ./modules/home-manager.nix
          ./modules/shell.nix
          ./modules/home.nix
          {
            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };

      homeConfigurations.linux-amd64 = home-manager.lib.homeManagerConfiguration rec {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs nixpkgs username; } // { system = "x86_64-linux"; };
        modules = [
          ./modules/home-manager.nix
          ./modules/shell.nix
          ./modules/home.nix
          {
            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };
    };
}
