# Máquina que verifica a^n b^n (versão final)
# Formato: estado_origem,simbolo_lido,simbolo_escrito,estado_destino,movimento

# marca o primeiro 'a' e avança para a direita
q0,a,X,q1,d
# se encontrar X em q0, avançar
q0,X,X,q0,d
# permitir pular Ys em q0
q0,Y,Y,q0,d
q0,ba,ba,q_accept,cc

# em q1: avançar sobre a, X e Y até encontrar b
q1,a,a,q1,d
q1,X,X,q1,d
q1,Y,Y,q1,d
# ao encontrar b, marcar como Y e voltar para a esquerda para achar X correspondente
q1,b,Y,q2,c
q1,ba,ba,q_reject,cc

# fase q2: voltar para esquerda até encontrar X
q2,a,a,q2,c
q2,Y,Y,q2,c
# ao encontrar X, voltar ao q0 e avançar para continuar
q2,X,X,q0,d
q2,ba,ba,q_reject,cc
