#!/usr/bin/env bats

load test_helper

@test "help for alias is available" {
  run phpenv-help 'alias'
  assert_success
  assert_line "Usage: phpenv alias <name> [<version> | --auto | --remove]"
  assert_line "Symlink a short name to an exact version.  Passing a second argument of"
}


@test "help for unalias is available" {
  run phpenv-help 'unalias'
  assert_success
  assert_line 'Usage: phpenv unalias <alias> [<alias> ...]'
  assert_line 'Remove one or more symlinks in the versions directory'
}

