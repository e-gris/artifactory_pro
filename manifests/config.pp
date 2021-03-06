# Artifactory Pro basic configuration
class artifactory_pro::config {
  # Default file sould have artifactory owner and group
  File {
    owner => $::artifactory::artifactory_user,
    group => $::artifactory::artifactory_group,
  }

  # Add the license file
  file { "${::artifactory::artifactory_home}/etc/artifactory.lic":
    ensure => file,
    source => $::artifactory_pro::license_file,
    mode   => '0640',
  }
}
