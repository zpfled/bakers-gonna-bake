require_relative './galois_field'
require_relative './xor'
require_relative './s_box'
require_relative './utils/hex'
require_relative './utils/utility'

module AES
  include SBox

  def decipher_aes(input_bytes, key_bytes)
    Utility.enforce_argument_type(Array, input_bytes)
    Utility.enforce_argument_type(Array, key_bytes)

    # Step 1
    # key_expansion

    # Step 2
    # add_round_key

    # Step 3
    sub_bytes(key_bytes)
    # shift_rows
    # mix_columns
    # add_round_key

    # Step 4
    # sub_bytes
    # shift_rows
    # add_round_key
  end


  def key_expansion_128(key_bytes)
    expanded_key = key_bytes
    expanded_key_length = 16
    iteration = 1
    prev = []

    while expanded_key_length < 176
      (0..3).each do |i|
        prev[i] = expanded_key[i + expanded_key_length - 4]
      end

      if (expanded_key_length % 16 == 0)
        prev = schedule_core(prev, iteration)
        iteration += 1
      end

      (0..3).each do |i|
        expanded_key[expanded_key_length] =
          expanded_key[expanded_key_length - 16] ^ prev[i]
        expanded_key_length += 1
      end
    end

    expanded_key
  end

  private

  def schedule_core(key_bytes, iteration)
    # The input is a 32-bit word and an iteration number i. The output is a 32-bit word.
    # Copy the input over to the output
    output = key_bytes
    # Use rotate to rotate the output eight bits to the left
    output = GaloisField256.rotate_eight_bits(output)
    # Apply Rijndael's S-box on all four individual bytes in the output word.
    output = sub_bytes(output)
    # On just the first (leftmost, MSB) byte of the output word,
    # exclusive or the byte with 2 to the power of i (rcon(i)).
    output[0] = output[0] ^ GaloisField256.rcon(iteration)
    # return output
    output
  end

  # def add_round_key

  # end

  # def shift_rows

  # end

  # def mix_columns

  # end
end
