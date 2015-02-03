require 'config'

module Utility
  require 'decoder_ring'

  module Web
    require 'net/http'

    def self.txt_file_to_array(url) # return an array of strings parsed from a website
      base = url.split('/')[0]
      path = '/' + url.split('/')[1..-1].join('/')
      Net::HTTP.get(base, path).split("\n")
    end
  end
end