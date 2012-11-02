puppet-apc
==========

Puppet module for installing &quot;Alternative PHP Cache&quot; (APC)

Installs APC Support with basis configuration.
Depends on (tested with)
 - https://github.com/camptocamp/puppet-apache.git
 - https://github.com/camptocamp/puppet-php.git

Example usage:

  include apc

  with parameter overrides:

  class{'::apc':
    param => 'value',
  }

Configuration:

  - edit params.pp to change default values
  - add new values to augeas-command in config.pp

Author:      Stefan Kögel
Contributor: Dave Simons [Inuits BVBA - inuits.eu]

GitHub: git@github.com:stkoegel/puppet-apc.git

Changelog:
Version 0.2 - Added CentOS support
            - Syntax update
            - Allow external overriding of parameters
            - Added 'stat', 'canonicalize' and 'include_once_override' values
Version 0.1 - Initial Commit for Debian/Ubuntu and three config values

ToDo:
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
