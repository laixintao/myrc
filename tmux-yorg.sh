# Quick open yorg working enviorment

cd ~/program/yorg/
tmux new-session -s yorg-dev -n yorg-vim -d

tmux new-window -n yorg-test -t yorg-dev

# vim window
tmux send-keys -t yorg-dev:1.1 C-m
tmux send-keys -t yorg-dev:1.1 'workon yorg' C-m
tmux send-keys -t yorg-dev:1.1 'vim' C-m

# yorg test
tmux split-window -h -t yorg-dev:2
tmux split-window -v -t yorg-dev:2
tmux split-window -v -t yorg-dev:2.2
tmux send-keys -t yorg-dev:2.1 'workon yorg' C-m
tmux send-keys -t yorg-dev:2.2 'workon yorg' C-m
tmux send-keys -t yorg-dev:2.2 'vtest-yorg' C-m
tmux send-keys -t yorg-dev:2.4 'workon yorg' C-m
tmux send-keys -t yorg-dev:2.3 'mongo' C-m

# yorg-control
tmux new-window -n yorg-control -t yorg-dev
tmux split-window -h -t yorg-dev:3

tmux send-keys -t yorg-dev:3.1 'cd ../yorg-control/' C-m
tmux send-keys -t yorg-dev:3.2 'cd ../yorg-control/' C-m
tmux send-keys -t yorg-dev:3.1 'workon yorg' C-m
tmux send-keys -t yorg-dev:3.2 'workon yorg' C-m

# yorg-control
tmux new-window -n brm-index -t yorg-dev
tmux split-window -h -t yorg-dev:4
tmux send-keys -t yorg-dev:4.1 'workon yorg' C-m
tmux send-keys -t yorg-dev:4.2 'workon yorg' C-m
tmux send-keys -t yorg-dev:4.1 'cd ../brm-index/' C-m
tmux send-keys -t yorg-dev:4.2 'cd ../brm-index/' C-m
tmux send-keys -t yorg-dev:4.1 'source .env.testing' C-m
tmux send-keys -t yorg-dev:4.1 'vim brm_index/datasource.py' C-m
tmux send-keys -t yorg-dev:4.2 'source .env.testing' C-m


# tools
tmux new-window -n tools -t yorg-dev
tmux split-window -h -t yorg-dev:5
tmux split-window -v -t yorg-dev:5 # 2.3 redis
tmux split-window -v -t yorg-dev:5 # 2.4 sslocal
tmux send-keys -t yorg-dev:5.3 'cd ~' C-m
tmux send-keys -t yorg-dev:5.3 'redis-server;if [ $? -eq 0 ];then echo success;else exit;fi' C-m
tmux send-keys -t yorg-dev:5.4 'mongod' C-m

tmux -2 attach -t yorg-dev:1
