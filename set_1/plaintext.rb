require_relative 'config'

module Plaintext

  module Convert
    def self.to_bytes(plaintext_string) # returns array of bytes as integers
      raise ArgumentError if plaintext_string.class != String
      plaintext_string.chars.map(&:ord)
    end

    def self.to_base64(plaintext_string) # encodes plaintext_string into base 64 equivalent
      raise ArgumentError if plaintext_string.class != String
      Base64.strict_encode64(plaintext_string)
    end
  end

  ##############################################################################

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