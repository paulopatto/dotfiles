#!/usr/bin/env bats
load test_helper

@test "it zshrc config exists in the new structure" {
  assert_file_exists "zsh/.config/zsh/zshrc"
}
@test "it nvim config exists in the new structure" {
  assert_file_exists "nvim/.config/nvim/init.lua"
}
@test "it tmux config exists in the new structure" {
  assert_file_exists "tmux/.config/tmux/tmux.conf"
}
