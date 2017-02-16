
# create a new session: -s [session name] -n [window name] -d 分离
tmux new-session -s demlution -n vim -d

# target [session]:[window].[pane]
tmux new-window -n panel -t demlution
tmux split-window -h -t demlution:2 # gulp 1.2
tmux split-window -v -t demlution:2 # webpack
tmux split-window -v -t demlution:2 # django，1.3
tmux split-window -v -t demlution:2 # shadow socks，1.4

# window for vim
tmux send-keys -t demlution:1.1 C-m # the first line usually is 'no session hint'
tmux send-keys -t demlution:1.1 'cd ~/program/bazaar4' C-m
tmux send-keys -t demlution:1.1 'curl wttr.in' C-m
# tmux send-keys -t demlution:1.1 'vim' C-m

# wondow for panel
tmux send-keys -t demlution:2.1 'cd ~/program/bazaar4' C-m
tmux send-keys -t demlution:2.1 'workon bz' C-m
tmux send-keys -t demlution:2.2 'cd ~/program/bazaar4' C-m
tmux send-keys -t demlution:2.2 'npm run dmhome' C-m
tmux send-keys -t demlution:2.3 'cd ~/program/bazaar4' C-m
tmux send-keys -t demlution:2.3 'gulp' C-m
tmux send-keys -t demlution:2.4 'cd ~/program/bazaar4' C-m
tmux send-keys -t demlution:2.4 'workon bz' C-m
tmux send-keys -t demlution:2.4 'python -Wi manage.py runserver' C-m
tmux send-keys -t demlution:2.5 'dem-sslocal' C-m
tmux select-layout -t demlution:2.1 main-vertical 
# TODO: select first window of demlution:2

# enter tmux, select vim window
tmux select-window -t demlution:1
tmux attach -t demlution



# refer
# https://pityonline.gitbooks.io/tmux-productive-mouse-free-development_zh/content/book-content/Chapter3.html
