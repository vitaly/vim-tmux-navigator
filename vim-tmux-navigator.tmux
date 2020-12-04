#!/usr/bin/env bash

version_pat='s/^tmux[^0-9]*([.0-9]+).*/\1/p'

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
tmux bind-key -n -N 'Select the pane to the left of the active pane'  M-h if-shell "$is_vim" "send-keys M-h" "select-pane -L"
tmux bind-key -n -N 'Select the pane below the active pane'           M-j if-shell "$is_vim" "send-keys M-j" "select-pane -D"
tmux bind-key -n -N 'Select the pane above the active pane'           M-k if-shell "$is_vim" "send-keys M-k" "select-pane -U"
tmux bind-key -n -N 'Select the pane to the right of the active pane' M-l if-shell "$is_vim" "send-keys M-l" "select-pane -R"
tmux_version="$(tmux -V | sed -En "$version_pat")"
tmux setenv -g tmux_version "$tmux_version"

#echo "{'version' : '${tmux_version}', 'sed_pat' : '${version_pat}' }" > ~/.tmux_version.json

tmux if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
  "bind-key -n -N 'Move to the previously active pane' 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\'  'select-pane -l'"
tmux if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
  "bind-key -n -N 'Move to the previously active pane' 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\'  'select-pane -l'"

tmux bind-key -T copy-mode-vi -N 'Select the pane to the left of the active pane'  M-h select-pane -L
tmux bind-key -T copy-mode-vi -N 'Select the pane below the active pane'           M-j select-pane -D
tmux bind-key -T copy-mode-vi -N 'Select the pane above the active pane'           M-k select-pane -U
tmux bind-key -T copy-mode-vi -N 'Select the pane to the right of the active pane' M-l select-pane -R
tmux bind-key -T copy-mode-vi -N 'Move to the previously active pane' M-\\ select-pane -l
