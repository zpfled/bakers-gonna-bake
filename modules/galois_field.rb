require_relative '../modules/utils/byte'
require_relative '../modules/utils/utility'
require_relative '../modules/and'
require_relative '../modules/xor'
require_relative '../modules/polynomial_math'
require 'prime'


module GaloisField256

  def self.add(x, y)
    XOR.gate([x], [y])
  end

  def self.subtract(x, y)
    add(x, y)
  end


  def self.multiply(x, y)
    # If x or y is zero, return 0
    if x * y == 0
      0

    # Else add log(x) and log(y) modulo 255, use sum as
    # index to lookup result on exponentiation table
    else
      Byte.from_hex(
        exponentiation_table[(log(x) + log(y)) % 255]
      )
    end
  end

  def self.multiplicative_inverse(byte)
    if byte == 0
      0
    else
      Byte.from_hex(inverses[byte])
    end
  end

  def self.log(n)
    Byte.from_hex(log_table[n])
  end

  def self.rotate_eight_bits(bytes)
    bytes.rotate
  end

  def self.rcon(byte)
    if byte == 0
      return byte
    else
      multiplier = 1
      while byte != 1
        multiplier = multiply(multiplier, 2)
        byte -=1
      end
      return multiplier
    end
  end


private

  def self.reducer
    '100011011'.to_i(2)
  end

  # from http://www.samiam.org/galois.html
  def self.exponentiation_table
    [
      '01', 'e5', '4c', 'b5', 'fb', '9f', 'fc', '12', '03', '34', 'd4', 'c4', '16', 'ba', '1f', '36',
      '05', '5c', '67', '57', '3a', 'd5', '21', '5a', '0f', 'e4', 'a9', 'f9', '4e', '64', '63', 'ee',
      '11', '37', 'e0', '10', 'd2', 'ac', 'a5', '29', '33', '59', '3b', '30', '6d', 'ef', 'f4', '7b',
      '55', 'eb', '4d', '50', 'b7', '2a', '07', '8d', 'ff', '26', 'd7', 'f0', 'c2', '7e', '09', '8c',
      '1a', '6a', '62', '0b', '5d', '82', '1b', '8f', '2e', 'be', 'a6', '1d', 'e7', '9d', '2d', '8a',
      '72', 'd9', 'f1', '27', '32', 'bc', '77', '85', '96', '70', '08', '69', '56', 'df', '99', '94',
      'a1', '90', '18', 'bb', 'fa', '7a', 'b0', 'a7', 'f8', 'ab', '28', 'd6', '15', '8e', 'cb', 'f2',
      '13', 'e6', '78', '61', '3f', '89', '46', '0d', '35', '31', '88', 'a3', '41', '80', 'ca', '17',
      '5f', '53', '83', 'fe', 'c3', '9b', '45', '39', 'e1', 'f5', '9e', '19', '5e', 'b6', 'cf', '4b',
      '38', '04', 'b9', '2b', 'e2', 'c1', '4a', 'dd', '48', '0c', 'd0', '7d', '3d', '58', 'de', '7c',
      'd8', '14', '6b', '87', '47', 'e8', '79', '84', '73', '3c', 'bd', '92', 'c9', '23', '8b', '97',
      '95', '44', 'dc', 'ad', '40', '65', '86', 'a2', 'a4', 'cc', '7f', 'ec', 'c0', 'af', '91', 'fd',
      'f7', '4f', '81', '2f', '5b', 'ea', 'a8', '1c', '02', 'd1', '98', '71', 'ed', '25', 'e3', '24',
      '06', '68', 'b3', '93', '2c', '6f', '3e', '6c', '0a', 'b8', 'ce', 'ae', '74', 'b1', '42', 'b4',
      '1e', 'd3', '49', 'e9', '9c', 'c8', 'c6', 'c7', '22', '6e', 'db', '20', 'bf', '43', '51', '52',
      '66', 'b2', '76', '60', 'da', 'c5', 'f3', 'f6', 'aa', 'cd', '9a', 'a0', '75', '54', '0e', '01'
    ]
  end

  def self.log_table
    [
      '--', '00', 'c8', '08', '91', '10', 'd0', '36', '5a', '3e', 'd8', '43', '99', '77', 'fe', '18',
      '23', '20', '07', '70', 'a1', '6c', '0c', '7f', '62', '8b', '40', '46', 'c7', '4b', 'e0', '0e',
      'eb', '16', 'e8', 'ad', 'cf', 'cd', '39', '53', '6a', '27', '35', '93', 'd4', '4e', '48', 'c3',
      '2b', '79', '54', '28', '09', '78', '0f', '21', '90', '87', '14', '2a', 'a9', '9c', 'd6', '74',
      'b4', '7c', 'de', 'ed', 'b1', '86', '76', 'a4', '98', 'e2', '96', '8f', '02', '32', '1c', 'c1',
      '33', 'ee', 'ef', '81', 'fd', '30', '5c', '13', '9d', '29', '17', 'c4', '11', '44', '8c', '80',
      'f3', '73', '42', '1e', '1d', 'b5', 'f0', '12', 'd1', '5b', '41', 'a2', 'd7', '2c', 'e9', 'd5',
      '59', 'cb', '50', 'a8', 'dc', 'fc', 'f2', '56', '72', 'a6', '65', '2f', '9f', '9b', '3d', 'ba',
      '7d', 'c2', '45', '82', 'a7', '57', 'b6', 'a3', '7a', '75', '4f', 'ae', '3f', '37', '6d', '47',
      '61', 'be', 'ab', 'd3', '5f', 'b0', '58', 'af', 'ca', '5e', 'fa', '85', 'e4', '4d', '8a', '05',
      'fb', '60', 'b7', '7b', 'b8', '26', '4a', '67', 'c6', '1a', 'f8', '69', '25', 'b3', 'db', 'bd',
      '66', 'dd', 'f1', 'd2', 'df', '03', '8d', '34', 'd9', '92', '0d', '63', '55', 'aa', '49', 'ec',
      'bc', '95', '3c', '84', '0b', 'f5', 'e6', 'e7', 'e5', 'ac', '7e', '6e', 'b9', 'f9', 'da', '8e',
      '9a', 'c9', '24', 'e1', '0a', '15', '6b', '3a', 'a0', '51', 'f4', 'ea', 'b2', '97', '9e', '5d',
      '22', '88', '94', 'ce', '19', '01', '71', '4c', 'a5', 'e3', 'c5', '31', 'bb', 'cc', '1f', '2d',
      '3b', '52', '6f', 'f6', '2e', '89', 'f7', 'c0', '68', '1b', '64', '04', '06', 'bf', '83', '38'
    ]
  end

  def self.inverses
    [
      '00', '01', '8d', 'f6', 'cb', '52', '7b', 'd1', 'e8', '4f', '29', 'c0', 'b0', 'e1', 'e5', 'c7',
      '74', 'b4', 'aa', '4b', '99', '2b', '60', '5f', '58', '3f', 'fd', 'cc', 'ff', '40', 'ee', 'b2',
      '3a', '6e', '5a', 'f1', '55', '4d', 'a8', 'c9', 'c1', '0a', '98', '15', '30', '44', 'a2', 'c2',
      '2c', '45', '92', '6c', 'f3', '39', '66', '42', 'f2', '35', '20', '6f', '77', 'bb', '59', '19',
      '1d', 'fe', '37', '67', '2d', '31', 'f5', '69', 'a7', '64', 'ab', '13', '54', '25', 'e9', '09',
      'ed', '5c', '05', 'ca', '4c', '24', '87', 'bf', '18', '3e', '22', 'f0', '51', 'ec', '61', '17',
      '16', '5e', 'af', 'd3', '49', 'a6', '36', '43', 'f4', '47', '91', 'df', '33', '93', '21', '3b',
      '79', 'b7', '97', '85', '10', 'b5', 'ba', '3c', 'b6', '70', 'd0', '06', 'a1', 'fa', '81', '82',
      '83', '7e', '7f', '80', '96', '73', 'be', '56', '9b', '9e', '95', 'd9', 'f7', '02', 'b9', 'a4',
      'de', '6a', '32', '6d', 'd8', '8a', '84', '72', '2a', '14', '9f', '88', 'f9', 'dc', '89', '9a',
      'fb', '7c', '2e', 'c3', '8f', 'b8', '65', '48', '26', 'c8', '12', '4a', 'ce', 'e7', 'd2', '62',
      '0c', 'e0', '1f', 'ef', '11', '75', '78', '71', 'a5', '8e', '76', '3d', 'bd', 'bc', '86', '57',
      '0b', '28', '2f', 'a3', 'da', 'd4', 'e4', '0f', 'a9', '27', '53', '04', '1b', 'fc', 'ac', 'e6',
      '7a', '07', 'ae', '63', 'c5', 'db', 'e2', 'ea', '94', '8b', 'c4', 'd5', '9d', 'f8', '90', '6b',
      'b1', '0d', 'd6', 'eb', 'c6', '0e', 'cf', 'ad', '08', '4e', 'd7', 'e3', '5d', '50', '1e', 'b3',
      '5b', '23', '38', '34', '68', '46', '03', '8c', 'dd', '9c', '7d', 'a0', 'cd', '1a', '41', '1c'
    ]
  end

end
