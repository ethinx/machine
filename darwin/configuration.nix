{ config, pkgs, system, username, ... }:
let
  isDarwin = system: (builtins.elem system pkgs.lib.platforms.darwin);
  homePrefix = system: if isDarwin system then "/Users" else "/home";
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";
  # environment.darwinConfig = "$HOME/.nixpkgs/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  #nix.package = pkgs.nixFlakes;
  nixpkgs = {
    config = {
      allowBroken = true;
    };
  };
  nix = {
    package = pkgs.nix;
    gc = {
      # Garbage collection
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 15d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
    settings = {
      substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
      trusted-users = [ "${username}" "root" "@admin" "@wheel" ];
    };
  };

  # Create /etc/bashrc that loads the nix-darwin environment.
  #programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users."${username}" = {
    home = "${homePrefix system}/${username}";
    shell = pkgs.fish;
  };
}
