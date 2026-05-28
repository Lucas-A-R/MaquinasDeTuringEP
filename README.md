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
Exemplos

```bash
ruby src_refactor/main.rb machines_refactor/cf_an_bn.mt inputs_refactor/cf_tests.in
ruby src_refactor/main.rb machines_refactor/cs_an_bn_cn.mt inputs_refactor/cs_tests.in
ruby src_refactor/main.rb machines_refactor/regular_a_star_b_star.mt inputs_refactor/regular_tests.in
```bash
Ativar debug
Para ver o passo a passo, edite src_refactor/maquina_turing_universal.rb e defina:

DEBUG = true

Depois de depurar, volte para:

DEBUG = false
antes de commitar.

Convenções e formato dos arquivos
Formato .mt
Cada transição em uma linha:

estado_origem,simbolo_lido,simbolo_escrito,estado_destino,movimento
Movimentos: d = direita, c = esquerda, cc = stay

Comentários: linhas que começam com # são ignoradas

Símbolo branco
Padrão: ba

O loader também aceita _ como sinônimo; prefira ba para consistência

Formato .in
Duas opções:

Cadeia compacta: aaabbb (o loader adiciona ba ao final automaticamente)

Tokenizado: a;a;a;b;b;b;ba (símbolos separados por ;)
Se o arquivo estiver vazio, o loader usa o símbolo branco como fita.

Marcação interna
X para a marcado, Y para b marcado, Z para c marcado

Testes rápidos
Criar arquivos de teste (PowerShell)

Set-Content inputs_refactor\cf_tests.in -Value "aaabbb"
Set-Content inputs_refactor\cs_tests.in -Value "aaabbbccc"
Set-Content inputs_refactor\regular_tests.in -Value "a;a;a;b;b;b;ba"
Criar arquivos de teste (bash)

printf "aaabbb" > inputs_refactor/cf_tests.in
printf "aaabbbccc" > inputs_refactor/cs_tests.in
printf "a;a;a;b;b;b;ba" > inputs_refactor/regular_tests.in
Rodar uma bateria simples (bash)

for m in machines_refactor/*.mt; do
  echo "Máquina: $m"
  for i in inputs_refactor/*.in; do
    echo "  Testando $i"
    ruby src_refactor/main.rb "$m" "$i"
  done
  echo "----"
done
Rodar uma bateria simples (PowerShell)

$machines = Get-ChildItem machines_refactor\*.mt
foreach ($m in $machines) {
  Write-Host "Máquina: $($m.Name)"
  Get-ChildItem inputs_refactor\*.in | ForEach-Object {
    Write-Host "  Testando $($_.Name)"
    ruby src_refactor/main.rb $m.FullName $_.FullName
  }
  Write-Host "----"
}

Boas práticas
Evitar stay em ciclos perigosos: transições do tipo estado,simbolo,*,mesmo_estado,cc frequentemente causam loops; prefira mover o cabeçote ou alterar símbolo/estado.

Padronizar branco: escolha ba e documente essa convenção.

Desativar DEBUG antes do commit (DEBUG = false).

Organizar inputs: crie subpastas por máquina e por tipo (valid, invalid) para facilitar testes automatizados.

Adicionar validação estática: um script que detecte transições potencialmente perigosas ajuda a evitar regressões.

Testes automatizados: crie um runner que compare saída real com saída esperada (ACEITA/REJEITA) e retorne código de erro para CI.

Mensagens de commit claras: ex.: fix: corrige cf_an_bn e loader; adiciona testes básicos.

Sugestões de arquivos adicionais
.gitignore para ignorar arquivos temporários e logs.

scripts/run_all_tests.sh ou scripts/run_all_tests.ps1 para executar a suíte de testes.

tests/expected_results.csv para mapear entradas a resultados esperados.

Exemplo de .gitignore sugerido

*.log
*.tmp
.DS_Store
/.vscode/
/.idea/
/tmp/
/node_modules/
*.swp

Exemplo de runner que gera CSV (bash)

#!/usr/bin/env bash
OUT="tests/results.csv"
mkdir -p tests
echo "machine,input,result" > "$OUT"
for m in machines_refactor/*.mt; do
  for i in inputs_refactor/*.in; do
    res=$(ruby src_refactor/main.rb "$m" "$i" 2>/dev/null | grep -Eo "Decidiu\\? (ACEITA|REJEITA)" | awk '{print $2}')
    echo "$(basename "$m"),$(basename "$i"),${res:-ERRO}" >> "$OUT"
  done
done
echo "Relatório gerado em $OUT"
Contato e versionamento
Mantenha o repositório versionado e com commits frequentes. Use mensagens claras, por exemplo:


fix: corrige cf_an_bn e loader; adiciona testes básicos
test: adiciona casos válidos e inválidos para anbncn


---

### Observações finais
- **O bloco acima é um único arquivo** pronto para colar em `README.md`.  
- Se quiser, eu gero também o `.gitignore` e o `scripts/run_all_tests.sh` como arquivos separados prontos para salvar.
