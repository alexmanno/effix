#!/usr/bin/env bash

: ${REMOTE:=https://github.com/alexmanno/effix.git}
: ${LOCAL:=$HOME/.effix}
: ${TARGET:=$HOME/bin}

BINDIR=$LOCAL/bin

__pull_repository() {
	cd $LOCAL &&
	env git checkout . &&
	env git pull --rebase --stat origin master
}

__clone_repository() {
	env git clone --depth=1 $REMOTE $LOCAL
}

_fetch_repository() {
	if test -d $LOCAL; then
		__pull_repository
	else
		__clone_repository
	fi
}

_link_binaries() {
	mkdir -p $TARGET &&
    ln -s $BINDIR/effix $TARGET/effix 2>/dev/null || true
}

_fetch_repository &&
_link_binaries
