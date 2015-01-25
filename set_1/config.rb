$LOAD_PATH.unshift(File.dirname(__FILE__))
require_relative 'decoder_ring'
require_relative 'xor'
require_relative 'crypto'
require_relative 'utility'

# Constants

ENGLISH_CHAR_FREQUENCY = {
  a: 8167,
  b: 1492,
  c: 2782,
  d: 4253,
  e: 12702,
  f: 2228,
  g: 2015,
  h: 6094,
  i: 6966,
  j: 153,
  k: 772,
  l: 4025,
  m: 2406,
  n: 6749,
  o: 7507,
  p: 1929,
  q: 95,
  r: 5987,
  s: 6327,
  t: 9056,
  u: 2758,
  v: 978,
  w: 2360,
  x: 150,
  y: 1974,
  z: 74
}

BIGRAMS = {
  th: 3882,
  he: 3681,
  in: 2283,
  er: 2178,
  an: 2140,
  re: 1749,
  nd: 1571,
  on: 1418,
  en: 1383,
  at: 1335,
  ou: 1285,
  ed: 1275,
  ha: 1274,
  to: 1169,
  or: 1151,
  it: 1134,
  is: 1109,
  hi: 1092,
  es: 1092,
  ng: 1053
}