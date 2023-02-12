#!/bin/bash

current_window=$(tmux display-message -p '#I')

for window_index in $(tmux list-windows | cut -d: -f1); do
    if [[ ${window_index} -gt ${current_window} ]] 
    then
        tmux kill-window -t $window_index;
    fi
done
