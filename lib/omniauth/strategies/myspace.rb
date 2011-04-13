require 'omniauth/core'
require 'multi_json'

module OmniAuth
  module Strategies
    #
    # Authenticate to Myspace via OAuth and retrieve basic
    # user information.
    #
    # Usage:
    #
    #    use OmniAuth::Strategies::Myspace, 'consumerkey', 'consumersecret'
    #
    class Myspace < OmniAuth::Strategies::OAuth
       OAUTH_REQUEST_TOKEN_URL = '/request_token'
       OAUTH_AUTHORIZATION_URL = '/authorize'
       OAUTH_ACCESS_TOKEN_URL  = '/access_token'

      # Initialize the middleware
      def initialize(app, consumer_key = nil, consumer_secret = nil, options = {}, &block)
        client_options = {
          :site => 'http://api.myspace.com',
          :http_method => :get,
          :request_token_path => OAUTH_REQUEST_TOKEN_URL,
          :access_token_path => OAUTH_ACCESS_TOKEN_URL,
          :authorize_path => OAUTH_AUTHORIZATION_URL,
          :exclude_body_hash => true,
          :scheme => :query_string
        }

        super(app, :myspace, consumer_key, consumer_secret, client_options, options)
      end

      # we have to override this method (and copy/paste the code from OmniAuth::Strategies::OAuth
      # so we can add a sleep before we redirect to the authorize_url
      # this is because Myspace doesn't update cache fast enough between the request and authorize phases...
      # so we need to give it some breathing room
      def request_phase
        request_token = consumer.get_request_token(:oauth_callback => callback_url)
        session['oauth'] ||= {}
        session['oauth'][name.to_s] = {'callback_confirmed' => request_token.callback_confirmed?, 'request_token' => request_token.token, 'request_secret' => request_token.secret}
        r = Rack::Response.new

        sleep 0.2 # added so that the cache has time to fill

        if request_token.callback_confirmed?
          r.redirect(request_token.authorize_url(options[:authorize_params]))
        else
          r.redirect(request_token.authorize_url(options[:authorize_params].merge(:oauth_callback => callback_url)))
        end

        r.finish
      rescue ::Timeout::Error => e
        fail!(:timeout, e)
      end

      def auth_hash
        user_info = self.user_info
        OmniAuth::Utils.deep_merge(super, {
          'uid' => user_info['user_id'],
          'user_info' => user_info,
          'extra' => {'user_hash' => user_hash}
        })
      end

      def user_info
        user_hash = self.user_hash

        {
          'name' => user_hash['name'],
          'image' => user_hash['image'],
          'user_id' => user_hash['userId']
        }
      end

      def user_hash
        @user_hash ||= MultiJson.decode(@access_token.get("/v1/user.json").body)
      end
    end
  end
end
