```mermaid

flowchart LR
  %% Máquina 1: a^n b^n (azul)
  subgraph ANBN["Máquina para a^n b^n"]
    direction LR
    A1((inicial))
    M1((marcar a))
    S1((buscar b))
    R1((retornar))
    F1((final))
    A1 -->|a -> X, R| M1
    M1 -->|X -> X, R| M1
    M1 -->|b -> Y, L| R1
    R1 -->|Y -> Y, L| R1
    R1 -->|ba/_ -> ba, R| A1
    A1 -->|ba/_ -> ba, R| F1
  end

  %% Máquina 2: a^n b^n c^n (verde)
  subgraph ANBNCN["Máquina para a^n b^n c^n"]
    direction LR
    A2((inicial))
    M2((marcar a))
    B2((marcar b))
    C2((marcar c))
    R2((retornar ao início))
    F2((final))
    A2 -->|a -> X, R| M2
    M2 -->|X -> X, R| M2
    M2 -->|b -> Y, R| B2
    B2 -->|Y -> Y, R| B2
    B2 -->|c -> Z, L| C2
    C2 -->|Z -> Z, L| C2
    C2 -->|ba/_ -> ba, R| R2
    R2 -->|X/Y/Z -> X/Y/Z, R (pular marcados)| A2
    A2 -->|ba/_ -> ba, R| F2
  end

  %% Máquina 3: a* b* (laranja)
  subgraph ASTARBSTAR["Máquina regular para a* b*"]
    direction LR
    A3((inicial))
    Q3((q0))
    Q3b((q1))
    F3((final))
    A3 -->|ε -> ε, R| Q3
    Q3 -->|a -> a, R| Q3
    Q3 -->|b -> b, R| Q3b
    Q3b -->|b -> b, R| Q3b
    Q3 -->|ba/_ -> ba, R| F3
    Q3b -->|ba/_ -> ba, R| F3
  end

  %% Legenda
  subgraph LEG["Legenda"]
    direction TB
    L1["X = a marcado; Y = b marcado; Z = c marcado"]
    L2["ba ou _ = símbolo branco (fita vazia)"]
    L3["R = direita; L = esquerda; formato: lido -> escrito, movimento"]
  end
