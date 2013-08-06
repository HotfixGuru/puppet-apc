class apc::params {

  $pkg = $operatingsystem ? {
    /Debian|Ubuntu/ => 'php-apc',
    /CentOS|RedHat/ => 'php-pecl-apc',
  }

  $conf = $operatingsystem ? {
    /Debian|Ubuntu/ => '/etc/php5/apache2/conf.d/apc.ini/.anon/',
    /CentOS|RedHat/ => '/etc/php.d/apc.ini/.anon/',
  }

  #specify the shared memory size
  #K - KB, M - MB, G - GB
  $shmsize = 128M

  #specify the number of shared memory segments
  $shmsegments = 1

  #specify the number of seconds until a cache entry will be expunged
  #the value 0 defines that entries are not expunged until the cache is full and the space is needed
  $ttl = 3600

  #When on this makes apc check the files every time they are queried to see if any modifications were made.
  #Turning this off will give a significant performance boost, but should only be used when the files served are not changed often.
  $stat = 1

  #If on, then relative paths are canonicalized in no-stat mode. If set, then files included via stream wrappers can not be cached as realpath() does not support stream wrappers.
  $canonicalize = 1

  #Turning this on optimizes the 'include_once' and 'require_once' calls, to avoid the expensive system calls used.
  $include_once_override = 0

}
