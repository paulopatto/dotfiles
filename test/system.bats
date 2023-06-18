load test_helper.bash 

@test "should jq installed" {
  assert [ -x $( command -v jq) ] 
}