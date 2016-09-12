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
      warning("You did not specify the apcu backwards compatibility package name, it will not be installed!")
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

  # really ugly hack which will create symlink for package 'php70-php-pecl-apcu.x86_64'
  # to the correct paths
  if $pkg == 'php70-php-pecl-apcu.x86_64' {
    file { '/usr/lib64/php/modules/apcu.so':
      ensure  => 'link',
      target  => '/opt/remi/php70/root/usr/lib64/php/modules/apcu.so',
      require => Package['apc'],
      notify  => Service['httpd'],
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
      notify  => Service['httpd'],
    }
  }

}
