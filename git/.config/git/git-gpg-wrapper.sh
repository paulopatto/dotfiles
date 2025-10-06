#!/usr/bin/env bash

case "$(uname -s)" in
  Darwin)
    exec /Applications/1Password.app/Contents/MacOS/op-ssh-sign "$@"
    ;;
  Linux)
    exec /opt/1Password/op-ssh-sign "$@"
    ;;
  *)
    echo "Unsupported OS $(uname -s)" >&2
    exit 1
    ;;
esac
