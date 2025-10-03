#!/usr/bin/env bats
load test_helper
setup() {
    # Create a fake home directory for testing
    FAKE_HOME="$(pwd)/tests/fake_home"
    mkdir -p "$FAKE_HOME"
    echo "👷🏾 Criado o diretório FAKE_HOME=$FAKE_HOME"
    # Ensure stow is available for the test, otherwise skip
    command -v stow >/dev/null || skip "stow not installed"
}

teardown() {
    # Clean up the fake home directory
    echo "🧹 Removendo diretório FAKE_HOME=$FAKE_HOME"
    rm -rf "$FAKE_HOME"
}


@test "it 'make link' creates symlinks" {
    # Override HOME directory for the make command
    HOME="$FAKE_HOME" make link
    # Check if a key symlink was created
    assert_link_exists "$FAKE_HOME/.config/zsh"
}

@test "it 'make link' creates symlinks with files" {
    # Override HOME directory for the make command
    HOME="$FAKE_HOME" make link

    # Check if a key symlink was created
    assert_file_exists "$FAKE_HOME/.config/zsh/zshrc"
}

@test "it 'make unlink' removes symlinks" {
    # First, create the links
    HOME="$FAKE_HOME" make link
    # Now, unlink them
    HOME="$FAKE_HOME" make unlink

    # Check if the symlink was removed
    assert_link_not_exists "$FAKE_HOME/.config/zsh"
}
