require 'omniauth/core'
require 'digest/md5'
require 'rest-client'
require 'multi_json'

module OmniAuth
  module Strategies
    class Lastfm
      include OmniAuth::Strategy

      attr_accessor :api_key, :secret_key, :options
      def initialize(app, api_key, secret_key, options = {})
        super(app, :lastfm)
        @api_key = api_key
        @secret_key = secret_key
        @options = options
      end

      def request_phase
        params = {:api_key => api_key }
        query_string = params.map{ |key,value| "#{key}=#{Rack::Utils.escape(value)}" }.join('&')
        redirect "http://www.last.fm/api/auth/?#{query_string}"
      end

      def callback_phase
        token = request.params['token']
        params = { :api_key => api_key }
        params[:token] = token
        params[:api_sig] = session_token_signature(token)
        params[:method] = "auth.getSession"
        params[:format] = "json"
        response = RestClient.get('http://ws.audioscrobbler.com/2.0/', { :params => params })
        @session = MultiJson.decode(response.to_s)
        super
      end
      def auth_hash
        user_info = self.user_info
        OmniAuth::Utils.deep_merge(super, {
          "uid" => user_info["user_id"],
          "credentials" => { "token" => @session['session']['key'] },
          "user_info" => user_info,
          "extra" => {"user_hash" => user_hash, "lastfm" => @session}
        })
      end

      def user_info
        user_hash = self.user_hash

        {
          "name" => user_hash['realname'],
          "image" => user_hash['image'][2]["#text"], #2 is the large image size
          "user_id" => user_hash['id'],
          "nickname" => user_hash['name']
        }
      end

      def user_hash
        return @user_hash if @user_hash
        params = { :api_key => api_key }
        params[:method] = "user.getInfo"
        params[:sk] = @session['session']['key']
        params[:format] = "json"
        response = RestClient.get('http://ws.audioscrobbler.com/2.0/', { :params => params })
        @user_hash = MultiJson.decode(response.to_s)["user"]
      end

      protected
        def session_token_signature(token)
          sign = "api_key#{api_key}methodauth.getSessiontoken#{token}#{secret_key}"
          Digest::MD5.hexdigest(sign)
        end
    end
  end
end