class apc::config {

  require apc

  package{ 'apc':
    ensure  => installed,
    name    => $apc::pkg,
    require => Class[
      '::php',
      '::apache'
    ],
  }

  file { $apc::conf:
    ensure  => file,
    content => template('apc/apc_ini.erb'),
    require => [
      Package['apc']
    ],
  }

}
