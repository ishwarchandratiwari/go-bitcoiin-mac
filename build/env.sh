#!/bin/sh

set -e

if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
fi

# Create fake Go workspace if it doesn't exist yet.
workspace="$PWD/build/_workspace"
root="$PWD"
bitcoiindir="$workspace/src/github.com/bitcoiinBT2"
if [ ! -L "$bitcoiindir/go-bitcoiin" ]; then
    mkdir -p "$bitcoiindir"
    cd "$bitcoiindir"
    ln -s ../../../../../. go-bitcoiin
    cd "$root"
fi

# Set up the environment to use the workspace.
GOPATH="$workspace"
export GOPATH

# Run the command inside the workspace.
cd "$bitcoiindir/go-bitcoiin"
PWD="$bitcoiindir/go-bitcoiin"

# Launch the arguments with the configured environment.
exec "$@"

