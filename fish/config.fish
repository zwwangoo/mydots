if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting ""

function on_exit --on-event fish_exit
    echo fish is now exiting
end

function show_command_duration --on-event fish_postexec
    if test $CMD_DURATION -gt 0
        set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
        echo "Cost: $duration"
        set CMD_DURATION 0
    end
end

# function fish_prompt
#     set -l user_char '$ '
#     if fish_is_root_user
#         set user_char '# '
#     end
# 
#     echo (set_color yellow)$USER (set_color purple)$user_char
# end

alias s='fasd -si' # show / search / select
# alias z='fasd_cd -d' # cd, same functionality as j in autojump
function z
    fasd_cd -d $argv
end

alias vi='nvim'
alias vim='nvim'

alias cl='clear'
alias tailf='tail -f'
alias curl='curl -H "Content-Type:application/json"'
alias jop='joplin'
alias ch='/Users/wen/.pyenv/shims/sshch'
alias pyenv_clone='bash $HOME/.myscript/pyenv_clone_with_packages.sh'
# # alias killall='pkill -f'
# 
# # git
alias igc='git checkout'
alias igpl='git pull'
alias igpp='git push'
alias igs='git status'
# 
function drcccp
	cp $HOME/projects/mchz/db-tool-collector/apple_pen/scripts/$1.py $HOME/projects/mchz/drcc-sdk/script/repo/
end
alias dcp='drcccp'
# 
# 
# # docker
alias dexec="bash $HOME/.myscript/docker_exec_by_name.sh"
alias dlogs="bash $HOME/.myscript/docker_logs_by_name.sh"
alias dtel="bash $HOME/.myscript/celery_rdb_exec.sh"
alias kep="bash $HOME/.myscript/kubectl_enter_pod.sh"
alias blog="bash $HOME/.myscript/export_blog_format.sh"

# thefuck
thefuck --alias | source
alias grep='ggrep'

# pyenv
set -x PYENV_VIRTUALENV_DISABLE_PROMPT 1
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)

# go
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -x PATH $GOROOT/bin $GOPATH/bin $PATH

# python mysql-client
set -x PATH /usr/local/opt/mysql-client/bin $PATH
set -x LDFLAGS "-L/usr/local/opt/mysql-client/lib"
set -x CPPFLAGS "-I/usr/local/opt/mysql-client/include"
set -x PKG_CONFIG_PATH /usr/local/opt/mysql-client/lib/pkgconfig

set -x LANG "en_US.UTF-8"
set fish_vi_force_cursor 1

# 这个要放在最后
vfox activate fish | source
