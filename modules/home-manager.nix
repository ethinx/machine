{ inputs, config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager = {
    enable = true;
  };
}
