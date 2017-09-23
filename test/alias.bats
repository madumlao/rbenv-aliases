#!/usr/bin/env bats

load test_helper

@test "phpenv-alias 1.8.7 --auto" {
  create_versions 1.8.7-p371  1.8.7-p99  1.8.7-p100

  run phpenv-alias 1.8.7 --auto
  assert_success
  assert_alias_version 1.8.7 1.8.7-p371
}

@test "phpenv-alias jruby-1.7 --auto with jruby" {
  create_versions jruby-1.7.2  jruby-1.7.11

  run phpenv-alias jruby-1.7 --auto
  assert_success
  assert_alias_version jruby-1.7 jruby-1.7.11
}

@test "phpenv-alias 2.1 --auto with semver" {
  create_versions 2.1.5  2.1.40

  run phpenv-alias 2.1 --auto
  assert_success
  assert_alias_version 2.1 2.1.40
}

@test "phpenv-alias name 1.8.7-p100" {
  create_versions 1.8.7-p371  1.8.7-p99  1.8.7-p100

  run phpenv-alias name 1.8.7-p100
  assert_success
  assert_alias_version name 1.8.7-p100
}

@test "phpenv-alias --auto" {
  create_versions 1.8.7-p371      1.8.7-p99        1.8.7-p100
  create_versions 1.2.3-p99-perf  1.2.3-p234-beta  1.2.3-p1-perf
  create_versions jruby-1.7.2     jruby-1.7.11
  create_versions 2.1.5           2.1.40

  run phpenv-alias --auto
  assert_success
  assert_alias_version 1.8.7 1.8.7-p371
  assert_alias_version 1.2.3 1.2.3-p234-beta
  assert_alias_version jruby-1.7 jruby-1.7.11
  assert_alias_version 2.1 2.1.40
}

@test "phpenv-alias 1.8.7-p371 --auto removes dangling alias" {
  # alias to non-existant version
  create_alias 1.8.7 1.8.7-p371

  run phpenv-alias 1.8.7 --auto

  assert_success
  assert [ ! -L "$PHPENV_ROOT/versions/1.8.7" ]
}

@test "phpenv-alias 1.8.7-p371 --auto redirects alias to highest remaining version" {
  create_versions 1.8.7-p100
  # alias to non-existant version
  create_alias 1.8.7 1.8.7-p371

  run phpenv-alias 1.8.7 --auto

  assert_success
  assert_alias_version 1.8.7 1.8.7-p100
}
