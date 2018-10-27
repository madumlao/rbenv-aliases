# Aliases for phpenv PHP versions

On most PHP systems, PHP versions are only distinguised up to the MAJOR.MINOR
number, disregarding the patch number. Service, socket, and command filenames
will typically be labeled, for example, as `php7.2-fpm`. [phpenv][] and
[php-build][], however, uses 3-part version strings of MAJOR.MINOR.PATCH.

phpenv-aliases allows you to create MAJOR.MINOR aliases for php versions in
phpenv that point to the full version name installed in phpenv.

## Creating a single alias with complete specification
Invoke `phpenv alias <name> <version>` to make a symbolic link from `<name>` to
`<version>` in the phpenv versions directory, effectively creating an alias.

~~~bash
$ phpenv alias 7.1 7.1.9
7.1 => 7.1.9
~~~

## Creating a single alias automatically
Invoke `phpenv alias <name> --auto` to make a symbolic link using the highest
patch version in <name>.

~~~bash
$ phpenv alias 7.1 --auto  
7.1 => 7.1.9
~~~

## Creating an alias for all installed versions
The `--auto` will look for each installed PHP patch version and create an alias
for the latest MAJOR.MINOR version. For example:

~~~bash
$ phpenv alias --auto
5.4 => 5.4.45
5.5 => 5.5.33
5.6 => 5.6.36
7.0 => 7.0.4
7.1 => 7.1.9
7.2 => 7.2.6
~~~

## php-build
If you're using [php-build][], `phpenv install A.B.C` automatically
invokes `phpenv alias A.B --auto`, so you'll always have up to date aliases
for point releases.

~~~bash
$ phpenv install 7.2.6
... (build output) ...
7.2 => 7.2.6
~~~

## Installation

    mkdir -p "$(phpenv root)/plugins"
    git clone git://github.com/madumlao/phpenv-aliases.git \
      "$(phpenv root)/plugins/phpenv-aliases"
    phpenv alias --auto

## Thanks

This plugin is based off of [rbenv-aliases][], but adapted for PHP.

[phpenv]: https://github.com/madumlao/phpenv
[php-build]: https://github.com/php-build/php-build
[rbenv-aliases]: https://github.com/tpope/rbenv-aliases

