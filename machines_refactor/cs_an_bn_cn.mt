# Máquina que aceita cadeias da forma a^n b^n c^n (versão corrigida)
# Formato: estado_origem,simbolo_lido,simbolo_escrito,estado_destino,movimento
# Símbolo branco usado aqui: ba
# Marcações: X para 'a' marcado, Y para 'b' marcado, Z para 'c' marcado

# Estado inicial q0: marcar um 'a' e ir buscar 'b'
q0,a,X,q1,d
# pular símbolos já marcados em q0
q0,X,X,q0,d
q0,Y,Y,q0,d
q0,Z,Z,q0,d
# se não houver mais símbolos (encontrou branco) -> aceita
q0,ba,ba,q_accept,cc

# Estado q1: avançar até encontrar um 'b' não marcado e marcá-lo
q1,a,a,q1,d
q1,X,X,q1,d
q1,Y,Y,q1,d
q1,Z,Z,q1,d
# ao encontrar b, marcar como Y e ir buscar c (voltar ou avançar conforme estratégia)
q1,b,Y,q2,d
# se chegar ao branco sem achar b -> rejeita
q1,ba,ba,q_reject,cc

# Estado q2: avançar até encontrar um 'c' não marcado e marcá-lo, então voltar
q2,b,b,q2,d
q2,Y,Y,q2,d
q2,Z,Z,q2,d
q2,c,Z,q3,c
# se chegar ao branco sem achar c -> rejeita
q2,ba,ba,q_reject,cc

# Estado q3: voltar à esquerda até encontrar o X correspondente; ao achar X, ir para q0 e avançar
q3,a,a,q3,c
q3,b,b,q3,c
q3,Y,Y,q3,c
q3,Z,Z,q3,c
q3,X,X,q0,d
# se voltar até o branco à esquerda sem achar X -> rejeita
q3,ba,ba,q_reject,cc
