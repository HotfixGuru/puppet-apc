#
class apc::config (
  $conf,
  $pkg,
  $apcu_backwards_compatibility,
  $backwards_compatibility_pkg,
) {

  require apc

  package{ 'apc':
    ensure  => installed,
    name    => $pkg,
    require => Class[
      '::php',
      '::apache'
    ],
  }

  if $apcu_backwards_compatibility {
    if $backwards_compatibility_pkg == undef {
      warning('You did not specify the apcu backwards compatibility package name, it will not be installed!')
    }
    else {
      package{ $backwards_compatibility_pkg:
        ensure  => installed,
        require => Package['apc'],
      }
    }
  }

  file { $conf:
    ensure  => file,
    content => template('apc/apc_ini.erb'),
    require => [
      Package['apc']
    ],
  }

}
