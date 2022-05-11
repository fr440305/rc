#!/bin/env bash

alias ll='ls -ahl'
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | sed -e 's/^ //' | sed -e 's/$/ /'
}
export PATH=$PATH:/usr/local/go/bin:/home/user/bin
export GPG_TTY=$(tty)
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
