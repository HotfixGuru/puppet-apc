class apc::config {

  require ::apc

  package{"apc":
    name    => $pkg,
    ensure  => 'installed',
    require => Class[
      '::php',
      '::apache'
    ],
  }

  file { "${conf}":
    ensure => file,
    content => template('apc/apc_ini.erb'),
    require => [
       Package['apc']
     ],
  }

}
