#!/bin/bash

# Tunnel through an NLP access machine to a machine running
# Jupyter and open Jupyter in a browser.

INNER_HOST=jagupard4
INNER_PORT=8889
OUTER_HOST=zyh@jacob.stanford.edu
OUTER_PORT=8889

echo "Tunnelling to $INNER_HOST:$INNER_PORT via $OUTER_HOST:$OUTER_PORT ..."
ssh -M -S jupyter-notebook -fnN -L "$OUTER_PORT:$INNER_HOST:$INNER_PORT" "$OUTER_HOST" "$@"
ssh -S jupyter-notebook -O check "$OUTER_HOST"

#chromium-browser http://localhost:${OUTER_PORT}/ &disown

echo "Press Ctrl-C to kill the tunnel."
trap : SIGINT
cat > /dev/null
trap - SIGINT

echo "Killing..."
ssh -S jupyter-notebook -O exit "$OUTER_HOST"
