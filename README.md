puppet-apc
==========

Puppet module for installing &quot;Alternative PHP Cache&quot; (APC)

Installs APC Support with basis configuration.
Depends on (tested with)
 - https://github.com/camptocamp/puppet-apache.git
 - https://github.com/camptocamp/puppet-php.git

Example usage:

  include apc

Configuration:

  - edit params.pp to change predefinded values
  - add new values to augeas-command in depian.pp

Author: Stefan Kögel

GitHub: git@github.com:stkoegel/puppet-apc.git

Changelog:
Version 0.1 - Initial Commit for Debian/Ubuntu and three config values

ToDo:
- add support for RedHat and other os
- make configuration more flexible by defining a config class (see below)

define config ( $value ) {

    # $name is provided by define invocation

    # guid of this entry
    $key = $name

    $context = "/files/etc/php5/apache2/conf.d/apc.ini/"

     augeas { ".anon/$key":
       context => "$context",
       onlyif  => "get $key != '$value'",
       changes => "set $key '$value'",
     }
}