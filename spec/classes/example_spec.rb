require 'spec_helper'

describe 'artifactory_pro' do
  let(:params) { { license_file: 'my_license_key' } }

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "artifactory_pro class with simple license key" do
          it { is_expected.to compile.with_all_deps }

          # it { is_expected.to contain_class('artifactory_pro::params') }
          it { is_expected.to contain_class('artifactory').that_comes_before('artifactory_pro::config') }
          it { is_expected.to contain_class('artifactory_pro::config').that_comes_before('artifactory_pro::post_config') }
          it { is_expected.to contain_class('artifactory_pro::config') }
          it { is_expected.to contain_class('artifactory_pro::post_config') }
          it { is_expected.to contain_class('artifactory::service').that_subscribes_to('artifactory_pro::config') }
          it { is_expected.to contain_class('artifactory::service').that_subscribes_to('artifactory_pro::post_config') }

          it { is_expected.to contain_service('artifactory') }
          it { is_expected.to contain_package('jfrog-artifactory-pro').with_ensure('present') }
        end
      end
    end
  end
end
