#!/bin/sh

tmux new-session -s console-tools -n shadowsocks -d

tmux new-window -n temp -t console-tools

# shadowsocks on heroku
tmux send-keys -t console-tools:shadowsocks.1 "cd /Users/laixintao/Program/shadowsocks-heroku; start_shadowsocks_on_heroku" C-m
