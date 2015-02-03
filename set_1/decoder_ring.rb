require_relative 'config'

class DecoderRing
  attr_accessor :target, :keysize

  def initialize(opts)
    @target = opts.fetch[:target]
    @max_key_size = opts[:max_key_size] || 40
  end

  def self.find_keysize(target, max_keysize=40)

  end

  def self.single_substitution(input, key=nil)
    messages = {}
    keys = (key ? [key] : 0..255)
    keys.each do |k|
      potential_key = Array.new(Hex.to_bytes(input).length, k)
      message = Hex.to_plaintext(DecoderRing::XOR.fixed(Hex.to_bytes(input), potential_key))
      next if Plaintext.score(message) == 0
      messages[Plaintext.score(message)] = message
    end
    return (messages.max ? messages.max[1] : "")
  end

  def self.find_needle(haystack, method)
    potential_messages = {}
    Utility::Web.txt_file_to_array(haystack).each do |line|
      try = self.send(method, line)
      next if Plaintext.score(try) < 10000
      potential_messages[Plaintext.score(try)] = try
    end
    potential_messages.max
  end
end