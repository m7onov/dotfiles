#!/bin/bash

WDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PAGER="nvim -u $WDIR/.pager.vimrc -"; export PAGER
PSQL_EDITOR="nvim"; export PSQL_EDITOR
EDITOR="nvim -c \"set syntax=sql\""; export EDITOR
USER=postgres
if [ ! -z "$1" ]
then
  USER="$1"
  shift
fi

source _psql_hosts.sh

