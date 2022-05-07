{pkgs, system, username, ...}:
let
  isDarwin = system: (builtins.elem system pkgs.lib.platforms.darwin);
  homePrefix = system: if isDarwin system then "/Users" else "/home";
in
  {
    users.users."${username}" = {
      home = "${homePrefix system}/${username}";
      shell = pkgs.fish;
    };

    programs.fish = {
      enable = true;
      shellInit = ''
          fish_add_path -a ~/.rd/bin
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
      '';
    };
  }
