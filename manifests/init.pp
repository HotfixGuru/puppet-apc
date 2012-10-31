/*
== Class: apc

Installs APC Support with basis configuration.
Depends on (tested with)
 - https://github.com/camptocamp/puppet-apache.git
 - https://github.com/camptocamp/puppet-php.git

Example usage:

  include apc

Configuration:

  - edit params.pp to change predefinded values
  - add new values to augeas-command in depian.pp
*/

class apc {
    case $operatingsystem {
        Debian,Ubuntu,CentOS:  { include apc::config}
        default: { fail "Unsupported operatingsystem ${operatingsystem}" }
    } 
}