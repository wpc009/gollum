require 'cgi'

module Precious
  module Views
    class Layout < Mustache
      include Rack::Utils
      alias_method :h, :escape_html

      attr_reader :name

      def escaped_name
        CGI.escape(@name)
      end

      def title
        "Home"
      end

      # Passthrough additional omniauth parameters for status bar
      def user_authed
        @user_authed
      end
      
      def user_provider
        @user.provider
      end
      
      def user_name
        @user.name
      end
    end
  end
end
