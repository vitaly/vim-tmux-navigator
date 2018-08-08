#!/usr/bin/env bash

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
tmux bind-key -n M-h  if-shell "$is_vim" "send-keys M-h"  "select-pane -L"
tmux bind-key -n M-j  if-shell "$is_vim" "send-keys M-j"  "select-pane -D"
tmux bind-key -n M-k  if-shell "$is_vim" "send-keys M-k"  "select-pane -U"
tmux bind-key -n M-l  if-shell "$is_vim" "send-keys M-l"  "select-pane -R"
tmux bind-key -n M-\\ if-shell "$is_vim" "send-keys M-\\" "select-pane -l"
tmux bind-key -T copy-mode-vi C-h  select-pane -L
tmux bind-key -T copy-mode-vi C-j  select-pane -D
tmux bind-key -T copy-mode-vi C-k  select-pane -U
tmux bind-key -T copy-mode-vi C-l  select-pane -R
tmux bind-key -T copy-mode-vi C-\\ select-pane -l
