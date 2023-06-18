load test_helper.bash 

@test "should 1password installed" {
  echo "1Password version: $(op --version)"
  assert [ -x $( command -v op) ] 
}

@test "should 1password socket dir exists" {
  assert [ -d $HOME/.1password ] 
}

@test "should 1password agent ssh sign dir exists" {
  assert [ -d /opt/1Password/ ] 
}