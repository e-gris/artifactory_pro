# Class: artifactory_pro
# ===========================
#
# Full description of class artifactory_pro here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#

class artifactory_pro(
  String $license_key,
  String $yum_name = 'bintray-jfrog-artifactory-pro-rpms',
  String $yum_baseurl = 'http://jfrog.bintray.com/artifactory-pro-rpms',
  String $package_name = 'jfrog-artifactory-pro',
  Hash $plugin_urls = {},
  Optional[String] $jdbc_driver_url = undef,
  Optional[Enum['mssql', 'mysql', 'oracle', 'postgresql']] $db_type = undef,
  Optional[String] $db_url = undef,
  Optional[String] $db_username = undef,
  Optional[String] $db_password = undef,
  Optional[Boolean] $is_primary = true,

) {

  class{'::artifactory':
    yum_name                       => $yum_name,
    yum_baseurl                    => $yum_baseurl,
    package_name                   => $package_name,
    db_type                        => $db_type,
    db_url                         => $db_url,
    db_username                    => $db_username,
    db_password                    => $db_password,
    jdbc_driver_url                => $jdbc_driver_url,
    is_primary                     => $is_primary,
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
