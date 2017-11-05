
# create a new session: -s [session name] -n [window name] -d 分离
tmux new-session -s ifenglv-dev -n vim -d

# target [session]:[window].[pane]
tmux new-window -n panel -t ifenglv-dev
tmux split-window -h -t ifenglv-dev:2 # 2.2 redis
tmux split-window -v -t ifenglv-dev:2 # 2.3 django
tmux split-window -v -t ifenglv-dev:2 # 2.4 celery

# window for vim
tmux send-keys -t ifenglv-dev:1.1 C-m # the first line usually is 'no session hint'
tmux send-keys -t ifenglv-dev:1.1 'cd ~/Program/ifenglv/' C-m
tmux send-keys -t ifenglv-dev:1.1 'workon ifenglv' C-m
tmux send-keys -t ifenglv-dev:1.1 'mysql.server start' C-m
tmux send-keys -t ifenglv-dev:1.1 'curl wttr.in' C-m
# tmux send-keys -t ifenglv-dev:1.1 'vim' C-m

# wondow for panel
tmux send-keys -t ifenglv-dev:2.1 'cd ~/Program/ifenglv/' C-m
tmux send-keys -t ifenglv-dev:2.1 'workon ifenglv' C-m


tmux send-keys -t ifenglv-dev:2.4 'cd ~/Program/ifenglv/' C-m
tmux send-keys -t ifenglv-dev:2.4 'workon ifenglv' C-m
tmux send-keys -t ifenglv-dev:2.4 'redis-server' C-m


tmux send-keys -t ifenglv-dev:2.3 'cd ~/Program/ifenglv/' C-m
tmux send-keys -t ifenglv-dev:2.3 'workon ifenglv' C-m
tmux send-keys -t ifenglv-dev:2.3 'celery -A ifenglv worker -l info' C-m

tmux send-keys -t ifenglv-dev:2.2 'cd ~/Program/ifenglv/' C-m
tmux send-keys -t ifenglv-dev:2.2 'workon ifenglv' C-m
tmux send-keys -t ifenglv-dev:2.2 'python manage.py runserver' C-m

tmux select-layout -t ifenglv-dev:2.1 main-vertical 
# TODO: select first window of ifenglv-dev:2

# enter tmux, select vim window
tmux select-window -t ifenglv-dev:1
tmux attach -t ifenglv-dev



# refer
# https://pityonline.gitbooks.io/tmux-productive-mouse-free-development_zh/content/book-content/Chapter3.html
