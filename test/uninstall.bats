#!/usr/bin/env bats

load test_helper

@test "running phpenv-uninstall auto removes the alias" {
  create_versions 1.9.3-p123
  create_alias 1.9.3 1.9.3-p123

  run phpenv-uninstall 1.9.3-p123

  assert_success
  assert_line 'Uninstalled fake version 1.9.3-p123'
  assert_line_starts_with 'Removing invalid link from 1.9.3'
  assert [ ! -L "$PHPENV_ROOT/versions/1.9.3" ]
}

@test "running phpenv-uninstall auto updates the alias to highest remaining version" {
  create_versions 1.9.3-p123 1.9.3-p456
  create_alias 1.9.3 1.9.3-p456

  run phpenv-uninstall 1.9.3-p456

  assert_success
  assert_line 'Uninstalled fake version 1.9.3-p456'
  assert_line_starts_with 'Removing invalid link from 1.9.3'
  assert_line '1.9.3 => 1.9.3-p123'
  assert_alias_version 1.9.3 1.9.3-p123
}

@test "running phpenv-uninstall auto updates the alias to highest remaining semver version" {
  create_versions 2.1.3 2.1.5
  create_alias 2.1 2.1.5

  run phpenv-uninstall 2.1.5

  assert_success
  assert_line 'Uninstalled fake version 2.1.5'
  assert_line_starts_with 'Removing invalid link from 2.1'
  assert_line '2.1 => 2.1.3'
  assert_alias_version 2.1 2.1.3
}

@test "running phpenv-uninstall auto updates the alias to highest remaining version, handling multi-segment patches" {
  create_versions 1.9.3-p123 1.9.3-p456-perf
  create_alias 1.9.3 1.9.3-p456-perf
  create_alias 1.9.3-p456 1.9.3-p456-perf

  run phpenv-uninstall 1.9.3-p456-perf

  assert_success
  assert_line 'Uninstalled fake version 1.9.3-p456-perf'
  assert_line_starts_with 'Removing invalid link from 1.9.3 '
  assert_line_starts_with 'Removing invalid link from 1.9.3-p456'
  assert_line '1.9.3 => 1.9.3-p123'
  assert_alias_version 1.9.3 1.9.3-p123
}
