class apc::config {

  require ::apc

  case $php_version {
    '5.3': {
      $pkg = $::operatingsystem ? {
        /Debian|Ubuntu/ => 'php-apc',
        CentOS          => 'php-pecl-apc',
      }

      $conf = $::operatingsystem ? {
        /Debian|Ubuntu/ => '/etc/php5/apache2/conf.d/apc.ini/',
        CentOS          => '/etc/php.d/apc.ini/',
      }
    }
    #install apcu instead of apc for php versions other than 5.3
    '5.5': {
      $pkg = $::operatingsystem ? {
        /Debian|Ubuntu/ => 'php-apcu',
        CentOS          => 'php-pecl-apcu',
      }

      $conf = $::operatingsystem ? {
        /Debian|Ubuntu/ => '/etc/php5/apache2/conf.d/apcu.ini/',
        CentOS          => '/etc/php.d/apcu.ini/',
      }
    }
  }

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
