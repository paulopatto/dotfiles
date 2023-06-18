load test_helper.bash 

@test "should neovim installed" {
  assert [ -x $( command -v nvim) ] 
}

@test "should have init.vim" {
  assert_file_exist $HOME/.config/nvim/init.vim 
}