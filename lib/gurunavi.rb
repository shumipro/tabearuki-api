require 'faraday'
require 'faraday_middleware'
require 'multi_xml'

module Gurunavi
  class Client
    def initialize(access_key)
      @access_key = access_key
      @connection = ::Faraday.new(url: 'http://api.gnavi.co.jp') do |conn|
        conn.response :json, :content_type => /\bjson$/
        conn.response :xml, :content_type => /\bxml$/

        conn.use :instrumentation
        conn.adapter ::Faraday.default_adapter
      end
    end

    def ouen_photo_search(lat:, lng: )
      response = @connection.get '/ouen/ver1/PhotoSearch/', {
        keyid: @access_key,
        format: "json",
        latitude: lat,
        longitude: lng,
        range: 1,
        hit_per_page: 50
      }
      response.body
    end
  end
end