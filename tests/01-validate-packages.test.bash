#!/usr/bin/env bats
load test_helper

@test "it stow be installed" {
    run command -v stow
    [ "$status" -eq 0 ]
}

@test "it make be installed" {
    run command -v make
    [ "$status" -eq 0 ]
}

@test "it git be present" {
    run command -v git
    [ "$status" -eq 0 ]
}

@test "it zsh be present" {
    run command -v zsh
    [ "$status" -eq 0 ]
}

@test "it tmux be present" {
    run command -v tmux
    [ "$status" -eq 0 ]
}

@test "it nvim be present" {
    run command -v nvim
    [ "$status" -eq 0 ]
}

@test "it lazygit be present" {
    run command -v lazygit
    [ "$status" -eq 0 ]
}

@test "it jq be present" {
    run command -v jq
    [ "$status" -eq 0 ]
}

@test "it lazydocker be present" {
    run command -v lazydocker
    [ "$status" -eq 0 ]
}

@test "it fd be present" {
    run command -v fd
    [ "$status" -eq 0 ]
}
