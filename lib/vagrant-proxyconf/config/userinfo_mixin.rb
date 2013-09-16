require 'uri'

module VagrantPlugins
  module ProxyConf
    module Config
      # Helper module for Config classes.
      #
      # Creates userinfo accessors for the specified keys.
      module UserinfoMixin

        # Methods for the including class to specify userinfo keys.
        module ClassMethods
          # Adds userinfo accessors to the class.
          # Requires there is an accessor method with the key name.
          #
          # @param key [Symbol, String] the key name
          # @!macro [attach] userinfo
          #   @!method $1_user
          #     @return [String] the username for the $1 proxy
          #   @!method $1_pass
          #     @return [String] the password for the $1 proxy
          def userinfo(key)
            define_method("#{key}_user") { user(public_send(key)) }
            define_method("#{key}_pass") { pass(public_send(key)) }
          end
        end

        # Extends the including class with {ClassMethods}
        def self.included(base)
          base.extend ClassMethods
        end

        private

        def user(uri)
          URI.parse(uri).user if uri
        end

        def pass(uri)
          URI.parse(uri).password if uri
        end
      end
    end
  end
end
