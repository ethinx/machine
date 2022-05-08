{ pkgs, ... }:
let
  isDarwin = system: (builtins.elem system pkgs.lib.platforms.darwin);
  homePrefix = system: if isDarwin system then "/Users" else "/home";
in
{
  environment = {
    shells = with pkgs; [
      bash
      zsh
      fish
      "/etc/profiles/per-user/ethinx/bin/fish"
    ]; # list of acceptable shells in /etc/shells

    shellAliases = { };
  };
}
