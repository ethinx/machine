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
}
