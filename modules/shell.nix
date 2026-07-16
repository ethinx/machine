{ config, pkgs, system, username, ... }:
let
  isDarwin = system: (builtins.elem system pkgs.lib.platforms.darwin);
  homePrefix = system: if isDarwin system then "/Users" else "/home";
  homeDirectory = "${homePrefix system}/${username}";
  shellEnv = ''
    . "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh"
  '';
in
{
  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/repo/golang/bin"
    "/etc/profiles/per-user/${username}/bin"
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/usr/sbin"
    "$HOME/.orbstack/bin"
    "$HOME/Library/Python/3.9/bin"
    "$HOME/.rd/bin"
    "$HOME/.local/share/nvim/mason/staging/beancount-language-server/bin"
  ];

  home.sessionVariables.BASH_ENV = "${homeDirectory}/.config/shell/nix.sh";

  home.file.".config/shell/nix.sh".text = shellEnv;

  # Keep standard rc files writable for installers; only add idempotent includes.
  home.activation.shellRcIncludes = config.lib.dag.entryAfter [ "linkGeneration" ] ''
    append_line() {
      local file="$1" line="$2"
      ${pkgs.coreutils}/bin/touch "$file"
      ${pkgs.gnugrep}/bin/grep -Fqx "$line" "$file" || printf '\n%s\n' "$line" >> "$file"
    }

    remove_line() {
      local file="$1" line="$2" tmp
      ${pkgs.gnugrep}/bin/grep -Fqx "$line" "$file" 2>/dev/null || return 0
      tmp="$(${pkgs.coreutils}/bin/mktemp)"
      ${pkgs.gnugrep}/bin/grep -Fvx "$line" "$file" > "$tmp" || true
      ${pkgs.coreutils}/bin/cat "$tmp" > "$file"
      ${pkgs.coreutils}/bin/rm "$tmp"
    }

    old_include='. "$HOME/.config/shell/nix.sh"'
    old_guarded_include='[ -f "$HOME/.config/shell/nix.sh" ] && . "$HOME/.config/shell/nix.sh"'
    include='if [ -f "$HOME/.config/shell/nix.sh" ]; then . "$HOME/.config/shell/nix.sh"; fi'
    old_profile_include='[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"'
    profile_include='if [ -f "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi'

    remove_line "$HOME/.bashrc" "$old_include"
    remove_line "$HOME/.bashrc" "$old_guarded_include"
    remove_line "$HOME/.bash_profile" "$old_profile_include"
    remove_line "$HOME/.zshenv" "$old_include"
    remove_line "$HOME/.zshenv" "$old_guarded_include"
    append_line "$HOME/.bashrc" "$include"
    append_line "$HOME/.bash_profile" "$profile_include"
    append_line "$HOME/.zshenv" "$include"
  '';

  programs.fzf = {
    enable = true;
  };
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path /etc/profiles/per-user/${username}/bin /run/current-system/sw/bin /nix/var/nix/profiles/default/bin /usr/sbin ~/.local/bin ~/.orbstack/bin
      fish_add_path -a $HOME/.local/share/nvim/mason/staging/beancount-language-server/bin
      set --export BUN_INSTALL "$HOME/.bun"
      set --export PATH $BUN_INSTALL/bin $PATH
      ${pkgs.z-lua}/bin/z.lua --init fish | source
      set fish_greeting
      set fish_color_normal B3B1AD
      set fish_color_command 39BAE6
      set fish_color_quote C2D94C
      set fish_color_redirection FFEE99
      set fish_color_end F29668
      set fish_color_error FF3333
      set fish_color_param B3B1AD
      set fish_color_comment 626A73
      set fish_color_match F07178
      set fish_color_selection --background=E6B450
      set fish_color_search_match --background=E6B450
      set fish_color_history_current --bold
      set fish_color_operator E6B450
      set fish_color_escape 95E6CB
      set fish_color_cwd 59C2FF
      set fish_color_cwd_root red
      set fish_color_valid_path --underline
      set fish_color_autosuggestion 4D5566
      set fish_color_user brgreen
      set fish_color_host normal
      set fish_color_cancel --reverse
      set fish_pager_color_prefix normal --bold --underline
      set fish_pager_color_progress brwhite --background=cyan
      set fish_pager_color_completion normal
      set fish_pager_color_description B3A06D
      set fish_pager_color_selected_background --background=E6B450

      # if [ $TERM = "xterm-kitty" ]
      #   alias ssh="kitty +kitten ssh"
      # end

    '';
    interactiveShellInit = ''
      fish_add_path -mP ~/repo/golang/bin
      fish_add_path -mP ~/.cargo/bin
      fish_add_path -mP ~/.local/bin
      fish_add_path -a ~/Library/Python/3.9/bin
      #fish_add_path -a ~/Library/Python/3.8/bin
      fish_add_path -a ~/.rd/bin
      fish_add_path -a /usr/sbin
      fish_add_path -a $HOME/.local/share/nvim/mason/staging/beancount-language-server/bin
      set --export BUN_INSTALL "$HOME/.bun"
      set --export PATH $BUN_INSTALL/bin $PATH
      export PKG_CONFIG_PATH=${pkgs.openssl.dev}/lib/pkgconfig
      export GOPATH=$HOME/repo/golang
      export CGO_ENABLED=0

      function _repo
          cd $HOME/repo
      end

      function _gopath
          if test -z $argv[1]
              cd $GOPATH/src
          else
              cd $GOPATH/src/$argv[1]
          end
      end

      alias repo="_repo"
      alias gopath="_gopath"
      alias logseq="cd $HOME/Library/Mobile\ Documents/iCloud~com~logseq~logseq/Documents/logseq"
      alias sls="cd $HOME/Library/Mobile\ Documents/iCloud~com~logseq~logseq/Documents/logseq && git add . && git commit -am 'sync'; git push"

      alias vim="nvim"
      alias vimdiff="nvim -d"

      export EDITOR=vim
      export VISUAL=vim

      if test -f $HOME/.fishrc
        source $HOME/.fishrc
      end
    '';
    plugins = [
      {
        name = "bass";
        src = pkgs.fishPlugins.bass;
      }
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
        };
      }
    ];
  };
}
