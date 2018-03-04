#!/usr/bin/env bash

set -ex

PREFIX="$1"

if [[ ! -d "$PREFIX" ]]; then
	echo "$PREFIX not found, creating..."

	mkdir -p "$PREFIX"
fi

GIT="git"
TARGET="git-extend"

DEFDIR="/usr/local"
BINDIR="bin"
ETCDIR="etc"
SRCDIR="src"

[[ ! -d "$PREFIX/$BINDIR" ]] && mkdir -p "$PREFIX/$BINDIR"
[[ ! -d "$PREFIX/$ETCDIR" ]] && mkdir -p "$PREFIX/$ETCDIR"

if [[ -f "$PREFIX/$BINDIR/$GIT" ]]; then
	echo "Found an executable at $PREFIX/$BINDIR/$GIT. Exiting..."

	exit 1
fi

INSTALL="/usr/bin/install"
OPTIONS="-c"

LN="/bin/ln"
LNOPTS="-sf"

cd ..

$INSTALL $OPTIONS "$SRCDIR/$TARGET" "$PREFIX/$BINDIR/$TARGET"
$LN $LNOPTS "$PREFIX/$BINDIR/$TARGET" "$PREFIX/$BINDIR/$GIT"
