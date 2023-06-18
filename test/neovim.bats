load test_helper.bash 

@test "should have init.vim" {
  assert_file_exist $HOME/.config/nvim/init.vim 
}