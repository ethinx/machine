{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraPackages = [ pkgs.tree-sitter ];
    withPython3 = true;
    withRuby = true;
  };

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
