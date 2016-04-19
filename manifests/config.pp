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

  # really ugly hack which will create symlink for package 'php70-php-pecl-apcu.x86_64'
  # to the correct paths
  if $apc::pkg == 'php70-php-pecl-apcu.x86_64' {
    file { '/usr/lib64/php/modules/apcu.so':
      ensure  => 'link',
      target  => '/opt/remi/php70/root/usr/lib64/php/modules/apcu.so',
      require => Package['apc'],
      notify  => Service[$::apache::params::notify_service],
    }

    file { '/var/lib/pear':
      ensure => directory,
      mode   => '0755',
      owner  => 'root',
      group  => 'root',
    } ->
    file { '/var/lib/pear/pkgxml':
      ensure => directory,
      mode   => '0755',
      owner  => 'root',
      group  => 'root',
    } ->
    file { '/var/lib/pear/pkgxml/php70-php-pecl-apcu.xml':
      ensure  => 'link',
      target  => '/opt/remi/php70/root/usr/lib64/php/modules/apcu.so',
      require => Package['apc'],
      notify  => Service[$::apache::params::notify_service],
    }
  }

}
