class apc::config {

    include apc::params
    
    package { "apc":
        name   => $apc::params::pkg,
        ensure => installed,
        require => [Class['php'],Class['apache']],
    }

    #specify your additional settings inside changes
    augeas{ "apc.ini settings":
        context => "/files/${apc::params::conf}",
        lens => "PHP.lns",
        incl => "${apc::params::conf}/apc.ini",
        changes => [
            "set enabled 1",
            "set shm_size ${apc::params::shmsize}",
            "set shm_segments ${apc::params::shmsegments}",
            "set ttl ${apc::params::ttl}"
        ],
        require => [ 
            Package["apc"],
            Class["augeas"],
        ],
    }  
}