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

tmux send-keys -t yorg-dev:3.1 'cd ../yorg-control/ ; workon yorg-control' C-m
tmux send-keys -t yorg-dev:3.2 'cd ../yorg-control/ ; workon yorg-control' C-m

# brm-index
tmux new-window -n brm-index -t yorg-dev
tmux split-window -h -t yorg-dev:4
tmux send-keys -t yorg-dev:4.1 'workon brm-index' C-m
tmux send-keys -t yorg-dev:4.2 'workon brm-index' C-m
tmux send-keys -t yorg-dev:4.1 'cd ../brm-index/' C-m
tmux send-keys -t yorg-dev:4.2 'cd ../brm-index/' C-m
tmux send-keys -t yorg-dev:4.1 'source .env.testing' C-m
tmux send-keys -t yorg-dev:4.1 'vim brm_index/datasource.py' C-m
tmux send-keys -t yorg-dev:4.2 'source .env.testing' C-m


# tools
tmux new-window -n tools -t yorg-dev
tmux split-window -h -t yorg-dev:5
tmux split-window -v -t yorg-dev:5.1 
tmux split-window -h -t yorg-dev:5.2 
tmux send-keys -t yorg-dev:5.2 'cd ~/Program/jupyter_notes; workon python3' C-m
tmux send-keys -t yorg-dev:5.3 'cd ~; redis-server;if [ $? -eq 0 ];then echo success;else exit;fi' C-m
tmux send-keys -t yorg-dev:5.4 'mongod' C-m

# mongo :6
tmux new-window -n mongo-ol -t yorg-dev
# do not use password in this file!

# brm-website :7
tmux new-window -n website -t yorg-dev
tmux send-keys -t yorg-dev:7.1 'cd ../brm-website' C-m

# brm-api :8
tmux new-window -n api -t yorg-dev
tmux send-keys -t yorg-dev:8.1 'cd ../brm-api' C-m
tmux send-keys -t yorg-dev:8.1 'workon brm-api' C-m

# run :9
tmux new-window -n run-onebox -t yorg-dev
tmux split-window -h -t yorg-dev:9
tmux split-window -v -t yorg-dev:9
tmux split-window -v -t yorg-dev:9
tmux send-keys -t yorg-dev:9.1 'cd /Users/laixintao/Program/brm-api' C-m
tmux send-keys -t yorg-dev:9.4 'redis-server --port 6388;if [ $? -eq 0 ];then echo success;else exit;fi' C-m
tmux send-keys -t yorg-dev:9.3 'cd ../brm-website' C-m
tmux send-keys -t yorg-dev:9.3 'npm run onebox' C-m
tmux send-keys -t yorg-dev:9.2 'cd /Users/laixintao/Program/brm-api; workon brm-api; credentials-to-env python manage.py runserver --threaded' C-m

tmux -2 attach -t yorg-dev:1
