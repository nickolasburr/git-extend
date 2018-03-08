#!/usr/bin/env bash

set -ex

PREFIX="$1"

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

if [[ ! -d "$PREFIX" ]]; then
	echo -e "${YELLOW}$PREFIX does not exist, attempting to create it...${RESET}"

	# Parent directory of $PREFIX.
	DIRNAME="$(dirname $PREFIX)"

	if [[ ! -w $DIRNAME ]]; then
		echo -e "${RED}Cannot create $PREFIX, $DIRNAME is not writable. Make $DIRNAME writable or install elsewhere. Exiting...${RESET}"

		exit 1
	fi

	mkdir -p "$PREFIX"

	echo -e "${GREEN}Successfully created ${PREFIX}${RESET}"
fi

GIT="git"
TARGET="git-extend"

DEFDIR="/usr"
BINDIR="bin"
ETCDIR="etc"

[[ ! -d "$PREFIX/$BINDIR" ]] && mkdir -p "$PREFIX/$BINDIR" && echo -e "${GREEN}Successfully created ${PREFIX}/${BINDIR}${RESET}"
[[ ! -d "$PREFIX/$ETCDIR" ]] && mkdir -p "$PREFIX/$ETCDIR" && echo -e "${GREEN}Successfully created ${PREFIX}/${ETCDIR}${RESET}"

if [[ -f "$PREFIX/$BINDIR/$GIT" ]] && [[ ! "$PREFIX/$BINDIR/$GIT" -ef "$PREFIX/$BINDIR/$TARGET" ]]; then
	echo -e "${RED}Found an executable at $PREFIX/$BINDIR/$GIT. Remove it manually to install here. Exiting...${RESET}"

	exit 1
fi

INSTALL="/usr/bin/install"
OPTIONS="-c"

LN="/bin/ln"
LNOPTS="-sf"

cd ..

$INSTALL $OPTIONS "$BINDIR/$TARGET" "$PREFIX/$BINDIR/$TARGET"
$LN $LNOPTS "$PREFIX/$BINDIR/$TARGET" "$PREFIX/$BINDIR/$GIT"
