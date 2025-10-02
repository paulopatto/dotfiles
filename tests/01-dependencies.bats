#!/usr/bin/env bats
@test "dependency: stow is installed" {
  run command -v stow
  [ "$status" -eq 0 ]
}
@test "dependency: make is installed" {
  run command -v make
  [ "$status" -eq 0 ]
}
