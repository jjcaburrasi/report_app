require 'json'
require 'rest-client'

class ApplicationController < ActionController::Base

    def hello
        render html: "WORKS!"
        url = "http://localhost:3000/api/v1/placements"
        response = RestClient.get(url)
        placements = JSON.parse(response)
        
    end
end
