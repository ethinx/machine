{
    description = "Nix flake configuration for person machines";

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
    };

    outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, darwin, ...}@inputs: let
    in {
        darwinConfigurations.macos-amd64 = import ./darwin {
            #{
            #  inherit name age; # equivalent to `name = name; age = age;`
            #  inherit (otherAttrs) email; # equivalent to `email = otherAttrs.email`;
            #}
            #inherit (nixpkgs) lib;

            inherit inputs nixpkgs nixpkgs-unstable home-manager darwin;
            system = "x86_64-darwin";
            username = "ethinx";
        };

        darwinConfigurations.macos-arm64 = import ./darwin {
            #{
            #  inherit name age; # equivalent to `name = name; age = age;`
            #  inherit (otherAttrs) email; # equivalent to `email = otherAttrs.email`;
            #}
            #inherit (nixpkgs) lib;

            inherit inputs nixpkgs nixpkgs-unstable home-manager darwin;
            system = "aarch64-darwin";
            username = "ethinx";
        };
    };
}
