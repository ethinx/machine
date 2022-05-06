{ pkgs, system, username, ... }:
let
    isDarwin = system: (builtins.elem system pkgs.lib.platforms.darwin);
    homePrefix = system: if isDarwin system then "/Users" else "/home";
in
{
    home = {
        username = "${username}";
        homeDirectory = "${homePrefix system}/${username}";

        packages = with pkgs; [
            go
            nodejs
            lua

            git
            vim
            neovim
            yarn

            cmake
            ctags
            cscope

            gh
            jq
            fzf
            tree
            watch
            ripgrep
            nmap
            mdbook
            ncdu

            lima
            vagrant

            z-lua
            chezmoi # dotfile manager
        ];

    };
}
