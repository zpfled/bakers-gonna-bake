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

  def self.find_needle(haystack, method)
    potential_messages = {}
    Web.txt_file_to_array(haystack).each do |line|
      try = DecoderRing.send(method, line)
      potential_messages[Plaintext.score(try)] = try
    end
    potential_messages.max
  end


  module Plaintext

    def self.score(plain_text)
      score_chars(plain_text)
      + score_bigrams(plain_text)
    end

  private

    def self.score_chars(plain_text)
      # return sum of relative frequencies of alphabetical characters in a string
      score = 0
      plain_text.chars.each do |letter|
        next if !ENGLISH_CHAR_FREQUENCY[letter.to_sym]
        score += ENGLISH_CHAR_FREQUENCY[letter.to_sym]
      end
      return score
    end

    def self.score_bigrams(plain_text)
      # return sum of relative frequencies of most common bigrams in English
      score = 0
      plain_text.chars.each_with_index do |letter, i|
        bigram = "#{letter}#{plain_text[i + 1]}"
        next if !BIGRAMS[bigram.to_sym]
        score += BIGRAMS[bigram.to_sym]
      end
      return score
    end
  end
end