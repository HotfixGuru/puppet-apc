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

  augeas{"apc.ini settings":
    context => "/files/${::apc::conf}",
    lens    => 'PHP.lns',
    incl    => "${::apc::conf}/apc.ini",
    changes => [
      'set enabled 1',
      "set shm_size ${::apc::shmsize}",
      "set shm_segments ${::apc::shmsegments}",
      "set ttl ${::apc::ttl}",
      "set stat ${::apc::stat}",
      "set canonicalize ${::apc::canonicalize}",
      "set include_once_override ${::apc::include_once_override}"
    ],
    require => [
      Package['apc'],
    ],
  }

}
