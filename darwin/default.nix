{ inputs, nixpkgs, nixpkgs-unstable, home-manager, darwin, system, username, ... }:

darwin.lib.darwinSystem rec {
  inherit system;

  # Pass args to modules?
  specialArgs = {
    inherit nixpkgs system username inputs;
  };
  modules = [
    ./configuration.nix
    ./env.nix

    home-manager.darwinModules.home-manager
    {
      # home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      # Pass arguments to home.nix
      # ref: https://nix-community.github.io/home-manager/index.html#sec-flakes-nix-darwin-module
      home-manager.extraSpecialArgs = { inherit nixpkgs username system; };
      home-manager.users.${username} = import ../modules/home.nix;
    }
  ];

}
