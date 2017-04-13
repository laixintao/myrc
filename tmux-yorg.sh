# Quick open yorg working enviorment

tmux new-session -s yorg-dev -n vim -d

tmux new-window -n run -t yorg-dev
tmux split-window -h -t yorg-dev:2 # 2.2 redis
tmux split-window -v -t yorg-dev:2 # 2.3 yorg
tmux split-window -v -t yorg-dev:2 # 2.4 breanstalk
tmux split-window -v -t yorg-dev:2 # 2.5 breanstalk

# vim window
tmux send-keys -t yorg-dev:1.1 C-m
tmux send-keys -t yorg-dev:1.1 'cd ~/program/yorg/' C-m
tmux send-keys -t yorg-dev:1.1 'workon yorg' C-m
tmux send-keys -t yorg-dev:1.1 'vim' C-m

tmux send-keys -t yorg-dev:2.1 'cd ~/program/yorg/' C-m
tmux send-keys -t yorg-dev:2.1 'workon yorg' C-m

tmux send-keys -t yorg-dev:2.2 'cd ~/program/yorg/' C-m
tmux send-keys -t yorg-dev:2.2 'workon yorg' C-m

tmux send-keys -t yorg-dev:2.3 'cd ~/program/yorg/' C-m
tmux send-keys -t yorg-dev:2.3 'workon yorg' C-m

tmux send-keys -t yorg-dev:2.4 'cd ~/program/yorg/' C-m
tmux send-keys -t yorg-dev:2.4 'workon yorg' C-m

tmux send-keys -t yorg-dev:2.5 'redis-server' C-m

tmux -2 attach -t yorg-dev:1
