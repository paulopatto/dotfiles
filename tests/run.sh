#!/usr/bin/env bash
set -e
# Define an absolute path to the tests directory
TESTS_DIR="$(cd "$(dirname "$0")" && pwd)"
# Define path to the bats executable
BATS_EXEC="${TESTS_DIR}/bats-core/bin/bats"
# Make sure the bats executable is runnable
chmod +x "$BATS_EXEC"
# Run all .bats files in the tests directory
"$BATS_EXEC" "${TESTS_DIR}"/*.bats
