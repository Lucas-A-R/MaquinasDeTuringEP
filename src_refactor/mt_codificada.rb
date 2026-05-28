# src_refactor/mt_codificada.rb
Q0 = "aa"
Q1 = "aaaa"
Q2 = "a"
B  = "ba"
X  = "bbba"
Y  = "bbbbbba"
ESQ = "c"
DIR = "cc"

D1 = "#{Q0},#{X},#{X},#{Q1},#{DIR}"
D2 = "#{Q1},#{Y},#{Y},#{Q1},#{DIR}"
D3 = "#{Q1},#{B},#{B},#{Q2},#{ESQ}"

def linker
  "#{D1};#{D2};#{D3}"
end

def codificacao_cadeia
  "#{X};#{Y};#{Y};#{Y};#{B}"
end
