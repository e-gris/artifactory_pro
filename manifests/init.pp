class artifactory_pro(
  String $license_file,
  String $yum_name = 'bintray-jfrog-artifactory-pro-rpms',
  String $yum_baseurl = 'http://jfrog.bintray.com/artifactory-pro-rpms',
  String $package_name = 'jfrog-artifactory-pro',
  Hash $plugin_urls = {},
  Optional[Boolean] $is_primary = true,
  Optional[Enum['mssql', 'mysql', 'oracle', 'postgresql']] $db_type = undef,
  Optional[String] $artifactory_etc = "/etc/opt/jfrog/artifactory",
  Optional[String] $artifactory_group = "artifactory",
  Optional[String] $artifactory_home = "/var/opt/jfrog/artifactory",
  Optional[String] $artifactory_user = "artifactory",
  Optional[String] $db_password = undef,
  Optional[String] $db_url = undef,
  Optional[String] $db_username = undef,
  Optional[String] $jdbc_driver_url = undef,
  Optional[String] $package_version = undef,
) {

  class{'::artifactory':
    artifactory_etc   => $artifactory_etc,
    artifactory_group => $artifactory_group,
    artifactory_home  => $artifactory_home,
    artifactory_user  => $artifactory_user,
    db_password       => $db_password,
    db_type           => $db_type,
    db_url            => $db_url,
    db_username       => $db_username,
    is_primary        => $is_primary,
    jdbc_driver_url   => $jdbc_driver_url,
    package_name      => $package_name,
    package_version   => $package_version,
    yum_baseurl       => $yum_baseurl,
    yum_name          => $yum_name,

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
