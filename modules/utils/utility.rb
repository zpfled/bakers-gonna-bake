module Utility

  # Descriptive, concise ArgumentErrors
  def self.enforce_argument_type(desired, arg)
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

    # return a string parsed from a text file on the web
    def self.txt_file_to_string(url)
      base = url.split('/')[0]
      path = '/' + url.split('/')[1..-1].join('/')
      Net::HTTP.get(base, path)
    end

    # return an array of strings parsed from a text file on the web
    def self.txt_file_to_array(url)
      txt_file_to_string(url).split("\n")
    end

  end
end