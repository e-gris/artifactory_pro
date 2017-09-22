class artifactory_pro(
  String $license_file,
  String $yum_name = 'bintray-jfrog-artifactory-pro-rpms',
  String $yum_baseurl = 'http://jfrog.bintray.com/artifactory-pro-rpms',
  String $package_name = 'jfrog-artifactory-pro',
  Hash $plugin_urls = {},
  Optional[String] $artifactory_user = "artifactory",
  Optional[String] $artifactory_group = "artifactory",
  Optional[String] $package_version = undef,
  Optional[String] $jdbc_driver_url = undef,
  Optional[Enum['mssql', 'mysql', 'oracle', 'postgresql']] $db_type = undef,
  Optional[String] $db_url = undef,
  Optional[String] $db_username = undef,
  Optional[String] $db_password = undef,
  Optional[Boolean] $is_primary = true,

) {

  class{'::artifactory':
    yum_name          => $yum_name,
    yum_baseurl       => $yum_baseurl,
    package_name      => $package_name,
    package_version   => $package_version,
    db_type           => $db_type,
    db_url            => $db_url,
    db_username       => $db_username,
    db_password       => $db_password,
    jdbc_driver_url   => $jdbc_driver_url,
    is_primary        => $is_primary,
    artifactory_user  => $artifactory_user,
    artifactory_group => $artifactory_group,
  }             ->
  class{'::artifactory_pro::config': } ->
  class{'::artifactory_pro::post_config': }

  # Ensure base Artifactory is configured before pro Artifactory
  Class['::artifactory::config']     ->
  Class['::artifactory_pro::config'] ~>
  Class['::artifactory::service']

  Class['::artifactory_pro::post_config'] ~>
  Class['::artifactory::service']
}
