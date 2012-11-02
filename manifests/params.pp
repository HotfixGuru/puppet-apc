class apc::params {

  $pkg = $operatingsystem ? {
    /Debian|Ubuntu/ => 'php-apc',
    CentOS          => 'php-pecl-apc',
  }

  $conf = $operatingsystem ? {
    /Debian|Ubuntu/ => '/etc/php5/apache2/conf.d/apc.ini/.anon/',
    centOS          => '/etc/php.d/apc.ini/.anon/',
  }

  #specify the shared memory size
  #K - KB, M - MB, G - GB
  $shmsize = 128M

  #specify the number of shared memory segments
  $shmsegments = 1

  #specify the number of seconds until a cache entry will be expunged
  #the value 0 defines that entries are not expunged until the cache is full and the space is needed
  $ttl = 3600

}
