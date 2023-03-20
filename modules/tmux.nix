{ pkgs, system, username, ... }:

{
  programs.tmux = {
    enable = true;
    tmuxp.enable = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
      }
    ];
    historyLimit = 10000;
    prefix = "C-a";
    baseIndex = 1;
    keyMode = "vi";
    extraConfig = ''
      set-window-option -g xterm-keys on
      bind a send-prefix
      bind e send-prefix

      bind R source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display-message "Config reloaded..."

      set -g monitor-activity on
      set -g visual-activity on

      set -g pane-base-index 1

      # copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      bind-key -T copy-mode-vi 'C-u' send -X page-up
      bind-key -T copy-mode-vi 'C-f' send -X page-down
      bind-key -T copy-mode-vi 'k' send -X cursor-up
      bind-key -T copy-mode-vi 'j' send -X cursor-down

      # alignment
      set-option -g status-justify centre 

      # spot at left
      #set-option -g status-left '#[bg=black,fg=green][#[fg=cyan]#S#[fg=green]]'
      set-option -g status-left-length 20

      # window list
      setw -g automatic-rename on
      #set-window-option -g window-status-format '#[dim]#I:#[default]#W#[fg=grey,dim]'
      #set-window-option -g window-status-current-format '#[fg=cyan,bold]#I#[fg=blue]:#[fg=cyan]#W#[fg=dim]'

      # spot at right
      #set -g status-right '#[fg=green][#[fg=cyan]%Y-%m-%d#[fg=green]]'

      # rebind pane tilling
      bind | split-window -h
      bind - split-window -v

      # pane selection
      bind j selectp -D
      bind k selectp -U
      bind h selectp -L
      bind l selectp -R

      # pane size adjust
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # ctrl-a meta-2 // switch window layout to type 2
      # ctrl-a space // switch window layout
      #
      set -g status-right-length 60
      set -g status-right "#(hostname) #(date)"

      # Set new panes to open in current directory
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind - split-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"

      # Remove SSH_AUTH_SOCK to disable tmux automatically resetting the variable
      set -g update-environment "DISPLAY SSH_ASKPASS SSH_AGENT_PID \
                                   SSH_CONNECTION WINDOWID XAUTHORITY SSH_AUTH_SOCK"

      # # Use a symlink to look up SSH authentication
      setenv -r SSH_AUTH_SOCK
      set-environment -g SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
      set-environment SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
    '';
  };
} 
