#!/usr/bin/env bash

set -ex

PREFIX="$1"

if [[ ! -d "$PREFIX" ]]; then
	printf '%s is not a valid directory.\n' "$PREFIX"

	exit 1
fi

SOURCE="git-wrap"
TARGET="git"
