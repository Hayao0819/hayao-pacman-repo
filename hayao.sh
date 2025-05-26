#!/bin/sh

if ! type ayaka >/dev/null 2>&1; then
    echo "ayaka not found, please install it first." >&2
    exit 1
fi

cd "$(dirname "$0")" || exit 1

ayaka "$@"
