{ pkgs, username, ... }:

{
  environment = {
    shells = with pkgs; [
      bash
      zsh
      fish
      "/etc/profiles/per-user/${username}/bin/fish"
    ]; # list of acceptable shells in /etc/shells

    shellAliases = { };
  };

  system.primaryUser = username;

  # GUI agents inherit this so non-interactive Bash loads the managed shell environment.
  launchd.user.envVariables.BASH_ENV = "/Users/${username}/.config/shell/nix.sh";
}
