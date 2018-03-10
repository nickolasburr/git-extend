#!/usr/bin/env bash

set -ex

PREFIX="$1"

if [[ ! -d "$PREFIX" ]]; then
	echo "$PREFIX is not a valid prefix. Exiting..."

	exit 1
fi

SOURCE="git-extend"
TARGET="git"
