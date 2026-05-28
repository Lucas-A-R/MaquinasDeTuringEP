```mermaid

flowchart LR
  %% =========================
  %% Máquina 1: a^n b^n
  %% =========================
  subgraph ANBN [Máquina para a^n b^n]
    direction LR
    A1((inicial))
    M1[(marcar a)]
    S1((buscar b))
    R1((retornar))
    F1((final))
    A1 -->| "a → X, R" | M1
    M1 -->| "X → X, R" | M1
    M1 -->| "b → Y, L" | R1
    R1 -->| "Y → Y, L" | R1
    R1 -->| "ba / _ → ba, R" | A1
    A1 -->| "ba / _ → ba, R" | F1
    %% legenda
    classDef blue fill:#e6f0ff,stroke:#2b6cb0,color:#0b3b66;
    class ANBN blue;
  end

  %% =========================
  %% Máquina 2: a^n b^n c^n
  %% =========================
  subgraph ANBNCN [Máquina para a^n b^n c^n]
    direction LR
    A2((inicial))
    M2[(marcar a)]
    B2[(marcar b)]
    C2[(marcar c)]
    R2((retornar ao início))
    F2((final))
    A2 -->| "a → X, R" | M2
    M2 -->| "X → X, R" | M2
    M2 -->| "b → Y, R" | B2
    B2 -->| "Y → Y, R" | B2
    B2 -->| "c → Z, L" | C2
    C2 -->| "Z → Z, L" | C2
    C2 -->| "ba / _ → ba, R" | R2
    R2 -->| "X/Y/Z → X/Y/Z, R (pular marcados)" | A2
    A2 -->| "ba / _ → ba, R" | F2
    %% legenda
    classDef green fill:#eefaf0,stroke:#2b8a3e,color:#0b4f2a;
    class ANBNCN green;
  end

  %% =========================
  %% Máquina 3: a* b* (regular)
  %% =========================
  subgraph ASTARBSTAR [Máquina regular para a* b*]
    direction LR
    A3((inicial))
    Q3((q0))
    Q3b((q1))
    F3((final))
    A3 -->| "ε → ε, R" | Q3
    Q3 -->| "a → a, R" | Q3
    Q3 -->| "b → b, R" | Q3b
    Q3b -->| "b → b, R" | Q3b
    Q3 -->| "ba / _ → ba, R" | F3
    Q3b -->| "ba / _ → ba, R" | F3
    %% legenda
    classDef orange fill:#fff4e6,stroke:#d97706,color:#7a3b00;
    class ASTARBSTAR orange;
  end

  %% =========================
  %% Legenda geral (visível abaixo dos diagramas)
  %% =========================
  subgraph LEG [Legenda]
    direction LR
    L1["X = a marcado; Y = b marcado; Z = c marcado"]
    L2["ba ou _ = símbolo branco (fita vazia)"]
    L3["Formato de rótulo: lido → escrito, movimento (R = direita, L = esquerda)"]
  end
