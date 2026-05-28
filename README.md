# MAQUINA DE TURING

Repositório com um simulador de Máquinas de Turing em Ruby, definições de máquinas (`.mt`) e entradas de teste (`.in`).  
Objetivo: facilitar criação, depuração e execução de máquinas (ex.: `a^n b^n`, `a^n b^n c^n`, `a* b*`).

---

## Estrutura do repositório
- **machines_refactor/** — definições das máquinas em `.mt`  
- **inputs_refactor/** — entradas de teste `.in` e subpastas para casos inválidos  
- **src_refactor/** — código refatorado do simulador (loader e `main.rb`)  
- **src_original/** — código original preservado

---

## Pré‑requisitos
- Ruby instalado (versão compatível com seu ambiente).

---

## Como executar
**Comando básico**
```bash
ruby src_refactor/main.rb machines_refactor/<maquina>.mt inputs_refactor/<entrada>.in

```bash
## Como executar
**Comando básico**
