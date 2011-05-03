require 'omniauth/core'

module OmniAuth
  module Strategies
    autoload :Myspace, 'omniauth/strategies/myspace'
    autoload :Lastfm, 'omniauth/strategies/lastfm'
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'H3BL8dMsgwUVb84wiiYcw', 'fsYfPBbuLH3NhkBku5co7cOIZY38b5WXUkeoOw7ka4'
  provider :facebook, '203396236349568', '307de383136a9e391ef546d5963a8c69', :display => 'popup'
  provider :myspace, '975d6719f792423aae0677446d9b745d', 'c1b68acdadb9458f832e069c91fbea8655103e15fc1949f48edd85c9ad3b3b92'
  provider :open_id, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :lastfm, '9d91f7e475e58b5c549df4b2d403a1c7', '0005026f1b56d1bbd734cc78934993a2'
end