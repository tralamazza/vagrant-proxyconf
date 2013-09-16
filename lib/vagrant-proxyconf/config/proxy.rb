require 'vagrant'
require_relative 'key_mixin'
require_relative 'userinfo_mixin'

module VagrantPlugins
  module ProxyConf
    module Config
      # Default configuration for all proxy Config classes
      #
      # @!parse class Proxy < Vagrant::Plugin::V2::Config; end
      class Proxy < Vagrant.plugin('2', :config)
        include UserinfoMixin
        include KeyMixin
        # @!parse extend UserinfoMixin::ClassMethods
        # @!parse extend KeyMixin::ClassMethods

        # @return [String] the HTTP proxy
        key :http, env_var: 'VAGRANT_HTTP_PROXY'
        userinfo :http

        # @return [String] the HTTPS proxy
        key :https, env_var: 'VAGRANT_HTTPS_PROXY'
        userinfo :https

        # @return [String] the FTP proxy
        key :ftp, env_var: 'VAGRANT_FTP_PROXY'

        # @return [String] a comma separated list of hosts or domains which do not use proxies
        key :no_proxy, env_var: 'VAGRANT_NO_PROXY'
      end
    end
  end
end
