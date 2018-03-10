#!/usr/bin/env bash

set -ex

GITPREFIX="$1"

if [[ ! -d "$GITPREFIX" ]]; then
	echo "$GITPREFIX is not a valid prefix. Exiting..."

	exit 1
fi

TARGET="git-extend"
BINDIR="bin"
# Default GITPREFIX value in git-extend.
DEFDIR="/usr"

SED="/usr/bin/sed"
SEDOPTS="-i ''"
SEDMATCH="s@$DEFDIR@$GITPREFIX@g"

cd ..

# Update GITPREFIX in git-extend, if needed.
[[ $GITPREFIX != $DEFDIR ]] && eval "$SED $SEDOPTS $SEDMATCH $BINDIR/$TARGET"
