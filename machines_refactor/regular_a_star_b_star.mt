# Máquina que aceita cadeias da forma a* b*
# Casos válidos: "", "aaa", "bbb", "aaabbb"
# Casos inválidos: "aba", "ba", "aabba"

q0,a,a,q0,d
q0,b,b,q1,d
q0,ba,ba,q_accept,d

q1,b,b,q1,d
q1,ba,ba,q_accept,d
q1,a,a,q_reject,d
