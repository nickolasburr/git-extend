#!/usr/bin/env bash

set -ex

GITPREFIX="$1"

if [[ ! -d "$GITPREFIX" ]]; then
	echo "$GITPREFIX is not a valid directory."

	exit 1
fi

TARGET="git-extend"
SRCDIR="src"
DEFDIR="/usr/local"

SED="/usr/bin/sed"
SEDOPTS="-i ''"
SEDMATCH="s@$DEFDIR@$GITPREFIX@g"

cd ..

# Update PREFIX in git-extend, if needed.
if [[ $GITPREFIX != $DEFDIR ]]; then
	eval "$SED $SEDOPTS $SEDMATCH $SRCDIR/$TARGET"
fi
