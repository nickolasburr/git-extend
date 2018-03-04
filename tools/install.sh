#!/usr/bin/env bash

set -ex

PREFIX="$1"
GITPREFIX="$2"

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

CP="/bin/cp"
CPOPTS="-rf"

RM="/bin/rm"
RMOPTS="-rf"

SED="/usr/bin/sed"
SEDOPTS="-i ''"
SEDMATCH="s@$DEFDIR@$GITPREFIX@g"

cd ..

$SED $SEDOPTS $SEDMATCH "$SRCDIR/$TARGET"
$INSTALL $OPTIONS "$SRCDIR/$TARGET" "$PREFIX/$BINDIR/$TARGET"
$LN $LNOPTS "$PREFIX/$BINDIR/$TARGET" "$PREFIX/$BINDIR/$GIT"
