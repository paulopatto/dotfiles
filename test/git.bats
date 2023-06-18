load test_helper.bash 

@test "should git installed" {
  assert [ -x $( command -v git) ] 
}

@test "should have .gitconfig file" {
  assert_file_exist $HOME/.gitconfig 
}

@test "should have .gitignore_global file" {
  assert_file_exist $HOME/.gitignore_global
}