require_relative 'config'

module Utility

  def self.descriptive_error(desired, arg)
    if arg.class != desired
      raise ArgumentError, "Pass in a #{desired}, not a #{arg.class}!"
    end
  end

  def self.groups_of(n, input, output=[])
    # recursive sexiness
    return (input.length > 0 ? output : output) if input.length < n
    output << input.shift(n)
    groups_of(n, input, output)
  end

  module Web
    require 'net/http'

    def self.txt_file_to_array(url) # return an array of strings parsed from a website
      base = url.split('/')[0]
      path = '/' + url.split('/')[1..-1].join('/')
      Net::HTTP.get(base, path).split("\n")
    end

    def self.txt_file_to_string(url) # return an array of strings parsed from a website
      base = url.split('/')[0]
      path = '/' + url.split('/')[1..-1].join('/')
      Net::HTTP.get(base, path)
    end
  end
end