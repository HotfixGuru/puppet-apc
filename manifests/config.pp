class apc::config {

  require ::apc

  package{"apc":
    name    => $::apc::pkg,
    ensure  => 'installed',
    require => Class[
      '::php',
      '::apache'
    ],
  }

  file { "${::apc::conf}":
    ensure => file,
    content => template('apc/apc_ini.erb'),
    require => [
       Package['apc']
     ],
  }

}
