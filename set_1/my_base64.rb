module MyBase64

  module Convert

    def self.to_bytes(base64_string)
      Utility.descriptive_error(String, base64_string)
      Base64.decode64(base64_string).chars.map(&:ord)
    end
  end
end