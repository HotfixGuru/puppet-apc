/*

== Class: apc

Installs APC Support with basic configuration.
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

*/

class apc (
  $pkg         = $::apc::params::pkg,
  $php         = $::apc::params::php,
  $conf        = $::apc::params::conf,
  $shmsize     = $::apc::params::shmsize,
  $shmsegments = $::apc::params::shmsegments,
  $ttl         = $::apc::params::ttl,
) inherits ::apc::params {

  case $operatingsystem {
    Debian,Ubuntu,CentOS:  { include apc::config }
    default:               { fail "Unsupported operatingsystem: ${operatingsystem}" }
  } 

}
