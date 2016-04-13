require 'benchmark'
require_relative './modules/utils/hamming'
require_relative './modules/utils/plaintext'

bytes1 = Plaintext.to_bytes("Peter")
bytes2 = Plaintext.to_bytes("Piper")

Benchmark.bmbm do |x|
  x.report { 100000.times { Hamming.distance(bytes1, bytes2) } }
end