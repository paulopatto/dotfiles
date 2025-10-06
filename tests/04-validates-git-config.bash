#!/usr/bin/env bats
load test_helper

@test "it git config in XDG_CONFIG_HOME exists in the new structure" {
  assert_file_exists "$HOME/.config/git/config"
}

@test "it git zsh envs exists" {
  assert_file_exists "$HOME/.config/zsh/envs/git.env.zsh"
}

@test "it environment variable GIT_CONFIG_GPG_SSH_PROGRAM is set in git.env.zsh" {
  run grep 'export GIT_CONFIG_GPG_SSH_PROGRAM=' "$HOME/.config/zsh/envs/git.env.zsh"
  [ "$status" -eq 0 ]
}
