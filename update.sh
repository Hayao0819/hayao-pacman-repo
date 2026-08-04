#!/bin/sh

set -eu

cd "$(dirname "$0")" || exit 1

if ! type ayaka >/dev/null 2>&1; then
    echo "ayaka not found, please install it first." >&2
    exit 1
fi

# The report exits non-zero when something is outdated; pull runs either way.
ayaka ci nvcheck || true
ayaka src pull hayao
