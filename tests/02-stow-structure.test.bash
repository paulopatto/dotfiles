#!/usr/bin/env bats
load test_helper

@test "it zshrc folder config file exists in the new structure" {
  assert_dir_exists "$HOME/.config/zsh/"
}

@test "it zshrc main config file exists in the new structure" {
  assert_file_exists "$HOME/.config/zsh/zshrc"
}

@test "it nvim main config file exists in the new structure" {
  assert_dir_exists "$HOME/.config/nvim/"
}

@test "it tmux main config file exists in the new structure" {
  assert_file_exists "$HOME/.config/tmux/tmux.conf"
}

@test "it git folder in XDG_CONFIG_HOME exists in the new structure" {
  assert_dir_exists "$HOME/.config/git/"
}

@test "it zplug folder in XDG_CONFIG_HOME exists in the new structure" {
  assert_dir_exists "$HOME/.config/zsh/plugins/zplug"
}

@test "it MCPHUB folder in XDG_CONFIG_HOME exists in the new structure" {
  assert_dir_exists "$HOME/.config/mcphub"
}

@test "it asdf executable on /usr/local/bin exists" {
  assert_file_exists "/usr/local/bin/asdf"
}

@test "it asdf folder in XDG_CONFIG_HOME exists in the new structure" {
  assert_dir_exists "$HOME/.config/asdf"
  assert_dir_exists "$HOME/.local/share/asdf"
}
