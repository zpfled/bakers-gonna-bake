require_relative 'config'

module Utility

  def self.groups_of(n, input, output=[])
    # recursive sexiness
    return (input.length > 0 ? output : output) if input.length < n
    output << input.shift(n)
    groups_of(n, input, output)
  end

  def self.decode64(target)
    p target_string_sans_newlines = Web.txt_file_string(target)
    Base64.decode64(target_string_sans_newlines).chars.map(&:ord)
    # Base64.decode64("HUIfTQsPAh9PE048GmllH0kcDk4TAQsHThsBFkU2AB4BSWQgVB0dQzNTTmVS").chars.map(&:ord)
  end

  module Web
    require 'net/http'

    def self.txt_file_to_array(url) # return an array of strings parsed from a website
      base = url.split('/')[0]
      path = '/' + url.split('/')[1..-1].join('/')
      Net::HTTP.get(base, path).split("\n")
    end

    def self.txt_file_string(url) # return an array of strings parsed from a website
      base = url.split('/')[0]
      path = '/' + url.split('/')[1..-1].join('/')
      Net::HTTP.get(base, path)
    end
  end
end