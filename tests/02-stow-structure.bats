#!/usr/bin/env bats
@test "stow structure: zsh config exists in the new structure" {
  [ -f "zsh/.config/zsh/.zshrc" ]
}
@test "stow structure: nvim config exists in the new structure" {
  [ -f "nvim/.config/nvim/init.lua" ]
}
@test "stow structure: tmux config exists in the new structure" {
  [ -f "tmux/.config/tmux/tmux.conf" ]
}
