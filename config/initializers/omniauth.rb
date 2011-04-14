require 'omniauth/core'

module OmniAuth
  module Strategies
    autoload :Myspace, 'omniauth/strategies/myspace'
  end
end

module OpenSSL
  module SSL
    remove_const :VERIFY_PEER
  end
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'H3BL8dMsgwUVb84wiiYcw', 'fsYfPBbuLH3NhkBku5co7cOIZY38b5WXUkeoOw7ka4'
  provider :facebook, '203396236349568', '307de383136a9e391ef546d5963a8c69', :display => 'popup'
  provider :myspace, '975d6719f792423aae0677446d9b745d', 'c1b68acdadb9458f832e069c91fbea8655103e15fc1949f48edd85c9ad3b3b92'
  provider :open_id, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end