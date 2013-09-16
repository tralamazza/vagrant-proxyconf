require 'vagrant'
require_relative 'key_mixin'
require_relative 'userinfo_mixin'

module VagrantPlugins
  module ProxyConf
    module Config
      # Proxy configuration for Yum
      #
      # @!parse class YumProxy < Vagrant::Plugin::V2::Config; end
      class YumProxy < Vagrant.plugin('2', :config)
        include UserinfoMixin
        include KeyMixin
        # @!parse extend UserinfoMixin::ClassMethods
        # @!parse extend KeyMixin::ClassMethods

        # @return [String] the HTTP proxy
        key :http, env_var: 'VAGRANT_YUM_HTTP_PROXY'
        userinfo :http
      end
    end
  end
end
