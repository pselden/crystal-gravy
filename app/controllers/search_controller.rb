require "net/http"
require "uri"

class SearchController < ApplicationController
  
  def show
    append_stylesheet "search/show"
    append_javascript "search/show"
  
    if  params[:q] == nil
          respond_with({:data => nil, :q => params[:q]})
    else
          uri = URI.parse("http://api.myspace.com/opensearch/music?searchterms="+URI.escape(params[:q]))
          http = Net::HTTP.new(uri.host, uri.port)
          request = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(request)
          data = ActiveSupport::JSON.decode(response.body)          
          respond_with({:data => data , :q => params[:q]})
    end
  end
  
    class Artist
      
    end
    
    class Songs
      
    end
    
    class Albums
      
    end

end
