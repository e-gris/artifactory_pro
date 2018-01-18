# Create any required resources for Artifactory Pro
class artifactory_pro::post_config {
  # Add the license file
  create_resources('::artifactory_pro::plugin', $::artifactory_pro::plugin_urls)
}
