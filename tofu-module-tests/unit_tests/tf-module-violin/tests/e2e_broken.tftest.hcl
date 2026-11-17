run "e2e_broken_assertion" {
  command = plan

  assert {
    condition     = output.instrument_name == "e2e-broken"
    error_message = "Forced failure: the module output does not match the expected value."
  }
}
