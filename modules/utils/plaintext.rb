require_relative './utility'
require_relative '../../constants'

module Plaintext

  def self.encode(bytes)
    Utility.enforce_argument_type(Array, bytes)
    bytes.map(&:chr).join
  end

  def self.to_bytes(plaintext) # returns array of bytes as integers
    Utility.enforce_argument_type(String, plaintext)
    plaintext.chars.map(&:ord)
  end

  def self.score(plain_text_string)
    score_chars(plain_text_string)
  end

  private

  def self.score_chars(plain_text_string)
    # return sum of relative frequencies of alphabetical characters in a string
    score = 0
    plain_text_string.chars.each do |letter|
      score += score_space_char(letter)
      if ENGLISH_CHAR_FREQUENCY[letter.to_sym]
        score += ENGLISH_CHAR_FREQUENCY[letter.to_sym]
      else
        next
      end
    end
    return score
  end

  def self.score_space_char(chr)
    if chr == " "
      13000
    else
      0
    end
  end

  # TODO: delete this if I can
  # def self.score_bigrams(plain_text_string)
  #   # return sum of relative frequencies of most common bigrams in English
  #   score = 0
  #   plain_text_string.chars.each_with_index do |letter, i|
  #     bigram = "#{letter}#{plain_text_string[i + 1]}"
  #     next if !BIGRAMS[bigram.to_sym]
  #     score += BIGRAMS[bigram.to_sym]
  #   end
  #   return score
  # end


  # TODO: delete this if I can
  # def self.score_trigrams(plain_text_string)
  #   # return sum of relative frequencies of most common trigrams in English
  #   score = 0
  #   plain_text_string.chars.each_with_index do |letter, i|
  #     trigram = "#{letter}#{plain_text_string[i + 1]}#{plain_text_string[i + 2]}"
  #     next if !TRIGRAMS[trigram.to_sym]
  #     score += TRIGRAMS[trigram.to_sym]
  #   end
  #   return score
  # end
end
