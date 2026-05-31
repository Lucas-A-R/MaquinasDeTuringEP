# MÁQUINAS DE TURING

Repositório com um simulador de Máquinas de Turing em Ruby, definições de máquinas (`.mt`) e entradas de teste (`.in`).  
## Objetivo: 
facilitar criação, depuração e execução de máquinas (ex.: `a^n b^n`, `a^n b^n c^n`, `a* b*`).

---

## Estrutura do repositório
- **machines_refactor/** — definições das máquinas em `.mt`  
- **inputs_refactor/** — entradas de teste `.in` e subpastas para casos inválidos  
- **src_refactor/** — código refatorado do simulador (loader e `main.rb`)  
- **src_original/** — código original preservado (usado como base para fazer as mts)

---

## Pré‑requisitos
- Ruby instalado.

---

## Como executar
**Comando básico**
```bash
ruby src_refactor/main.rb machines_refactor/<maquina>.mt inputs_refactor/<entrada>.in

```
## Exemplos
```bash

ruby src_refactor/main.rb machines_refactor/cf_an_bn.mt inputs_refactor/cf_tests.in
ruby src_refactor/main.rb machines_refactor/cs_an_bn_cn.mt inputs_refactor/cs_tests.in
ruby src_refactor/main.rb machines_refactor/regular_a_star_b_star.mt inputs_refactor/regular_tests.in

```
Cada mt contem um arquivo de testes adequado para as entradas serem validadas ou não
## Ativar debug
Para ver o passo a passo, edite src_refactor/maquina_turing_universal.rb e defina:

```ruby

DEBUG = true //localiza se na linha 24

```
Depois de depurar, volte para:

```ruby

DEBUG = false //localiza se na linha 24

```
antes de commitar.

## Convenções e formato dos arquivos

### Formato .mt

Cada transição em uma linha:

```Código

estado_origem,simbolo_lido,simbolo_escrito,estado_destino,movimento

```
- Movimentos: d = direita, c = esquerda, cc = stay

- Comentários: linhas que começam com # são ignoradas

## Símbolo branco
-Padrão: ba

-O loader também aceita _ como sinônimo; prefira ba para consistência

## Formato.in
Duas opções:

Cadeia compacta: aaabbb (o loader adiciona ba ao final automaticamente)

- Tokenizado: a;a;a;b;b;b;ba (símbolos separados por ;)
- Se o arquivo estiver vazio, o loader usa o símbolo branco como fita.

## Marcação interna

-X para a marcado, Y para b marcado, Z para c marcado

## Testes rápidos

### Criar arquivos de teste (PowerShell)

```powershell

Set-Content inputs_refactor\cf_tests.in -Value "aaabbb"
Set-Content inputs_refactor\cs_tests.in -Value "aaabbbccc"
Set-Content inputs_refactor\regular_tests.in -Value "a;a;a;b;b;b;ba"


```

### Criar arquivos de teste (bash)
```bash

printf "aaabbb" > inputs_refactor/cf_tests.in
printf "aaabbbccc" > inputs_refactor/cs_tests.in
printf "a;a;a;b;b;b;ba" > inputs_refactor/regular_tests.in


```




