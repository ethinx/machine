{ pkgs, ... }:

{
  environment = {
    shells = with pkgs; [
      bash
      zsh
      fish
    ]; # list of acceptable shells in /etc/shells

    shellAliases = { };
  };
}
