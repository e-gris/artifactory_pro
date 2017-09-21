#
#
define artifactory_pro::plugin(
  String $url,
  )
{
  # Default file sould have artifactory owner and group
  File {
    owner => $::artifactory::artifactory_user,
    group => $::artifactory::artifactory_group,
    mode  => 'a+rx',
  }

  $file_name =  regsubst($url, '.+\/([^\/]+)$', '\1')

  file {"${::artifactory::artifactory_home}/etc/plugins/${file_name}":
    ensure => file,
    source => $url,
    notify => Class['::artifactory::service'],
  }
}
