#!/usr/bin/env bash

set -ex

PREFIX="$1"

if [[ ! -d "$PREFIX" ]]; then
	echo "$PREFIX is not a valid directory. Exiting..."

	exit 1
fi

GIT="git"
TARGET="git-extend"

BINDIR="bin"
ETCDIR="etc"

RM="/bin/rm"
RMOPTS="-rf"

[[ "$PREFIX/$BINDIR/$GIT" -ef "$PREFIX/$BINDIR/$TARGET" ]] && $RM $RMOPTS "$PREFIX/$BINDIR/$GIT"
$RM $RMOPTS "$PREFIX/$BINDIR/$TARGET"
