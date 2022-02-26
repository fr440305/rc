#!/bin/env bash

alias ll='ls -ahl'

export PATH=$PATH:/usr/local/go/bin:/home/wtan/bin
export GPG_TTY=$(tty)
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
