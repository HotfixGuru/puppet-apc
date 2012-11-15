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
      'set apc.enabled 1',
      "set apc.shm_size ${::apc::shmsize}",
      "set apc.shm_segments ${::apc::shmsegments}",
      "set apc.ttl ${::apc::ttl}",
      "set apc.stat ${::apc::stat}",
      "set apc.canonicalize ${::apc::canonicalize}",
      "set apc.include_once_override ${::apc::include_once_override}"
    ],
    require => [
      Package['apc'],
    ],
  }

}
