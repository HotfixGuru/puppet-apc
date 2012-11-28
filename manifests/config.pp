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
    changes => [
      "set apc.enabled ${::apc::enabled}",
      "set apc.shm_size ${::apc::shmsize}",
      "set apc.shm_segments ${::apc::shmsegments}",
      "set apc.ttl ${::apc::ttl}",
      "set apc.stat ${::apc::stat}",
      "set apc.canonicalize ${::apc::canonicalize}",
      "set apc.include_once_override ${::apc::include_once_override}",
      "set apc.rfc1867 ${::apc::rfc1867}",
    ],
    require => [
      Package['apc'],
    ],
  }

}
