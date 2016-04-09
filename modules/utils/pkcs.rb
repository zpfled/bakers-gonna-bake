module PKCS

  def self.pad(bytes, desired_length)
    until bytes.length == desired_length
      bytes << 4
    end

    return bytes
  end
end
