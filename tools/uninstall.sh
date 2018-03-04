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

if [[ "$PREFIX/$BINDIR/$GIT" -ef "$PREFIX/$BINDIR/$TARGET" ]]; then
	$RM $RMOPTS "$PREFIX/$BINDIR/$GIT"
fi

$RM $RMOPTS "$PREFIX/$BINDIR/$TARGET"
