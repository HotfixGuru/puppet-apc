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
