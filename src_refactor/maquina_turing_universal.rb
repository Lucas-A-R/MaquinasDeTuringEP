#!/usr/bin/env ruby
# maquina_turing_universal.rb
# Loader robusto e simulador com logs controláveis.

class Transicao
  attr_reader :estado_origem, :simbolo_lido, :simbolo_escrito, :estado_destino, :movimento

  def initialize(estado_origem, simbolo_lido, simbolo_escrito, estado_destino, movimento)
    @estado_origem = estado_origem
    @simbolo_lido = simbolo_lido
    @simbolo_escrito = simbolo_escrito
    @estado_destino = estado_destino
    @movimento = movimento
  end

  def inspect
    "#{@estado_origem},#{@simbolo_lido},#{@simbolo_escrito},#{@estado_destino},#{@movimento}"
  end
end

class MaquinaTuringUniversal
  attr_reader :transicoes, :estado_inicial, :estados_aceitacao, :estados_rejeicao, :simbolo_branco

  DEBUG = false

  def initialize
    @transicoes = []
    @estado_inicial = 'q0'
    @estados_aceitacao = ['q_accept', 'accept', 'qf', 'final']
    @estados_rejeicao = ['q_reject', 'reject', 'qr']
    @simbolo_branco = 'ba'
    @max_passos = 10000
  end

  def log(*args)
    puts(*args) if DEBUG
  end

  def carregar_transicoes(caminho_mt)
    raw = File.read(caminho_mt).lines.map(&:chomp)
    raw.each do |linha|
      linha_stripped = linha.strip
      next if linha_stripped.empty?
      next if linha_stripped.start_with?('#')
      linha_sem_comentario = linha_stripped.split('#').first.strip
      next if linha_sem_comentario.empty?
      parts = linha_sem_comentario.split(',').map(&:strip)
      if parts.length != 5
        raise "Formato inválido de transição: '#{linha_sem_comentario}'. Esperado 5 campos separados por vírgula."
      end
      t = Transicao.new(parts[0], parts[1], parts[2], parts[3], parts[4])
      @transicoes << t
    end
  end

  # Aceita tokens separados por ';' ou cadeia compacta (ex: aaabbb)
  def carregar_fita(caminho_in)
    raw = File.read(caminho_in)
    return [] if raw.nil? || raw.strip.empty?
    raw = raw.gsub("\r", '').strip
    tokens = []
    if raw.include?(';')
      tokens = raw.split(';').map(&:strip)
      tokens.pop if tokens.last == ''
    else
      if raw.end_with?(@simbolo_branco)
        core = raw[0, raw.length - @simbolo_branco.length]
        tokens = core.chars.map(&:to_s)
        tokens << @simbolo_branco
      else
        tokens = raw.chars.map(&:to_s)
        tokens << @simbolo_branco
      end
    end
    tokens = [@simbolo_branco] if tokens.empty?
    tokens
  end

  # encontrar transição com tolerância para '_' como branco
  def encontrar_transicao(estado, simbolo)
    @transicoes.find do |t|
      if t.estado_origem == estado && t.simbolo_lido == simbolo
        true
      elsif t.estado_origem == estado && t.simbolo_lido == '_'
        simbolo == @simbolo_branco
      elsif t.estado_origem == estado && t.simbolo_lido == @simbolo_branco
        simbolo == '_' || simbolo == @simbolo_branco
      else
        false
      end
    end
  end

  def processar(caminho_mt, caminho_in)
    carregar_transicoes(caminho_mt)
    fita = carregar_fita(caminho_in)
    fita = [@simbolo_branco] if fita.empty?
    estado_atual = @estado_inicial
    posicao = 0

    log "DEBUG: Transições carregadas:"
    @transicoes.each_with_index { |t, i| log "  #{i}: #{t.inspect}" }
    log "DEBUG: Estado inicial: #{@estado_inicial.inspect}"
    log "DEBUG: Estados de aceitação conhecidos: #{@estados_aceitacao.inspect}"
    log "DEBUG: Estados de rejeição conhecidos: #{@estados_rejeicao.inspect}"
    log "DEBUG: Símbolo branco interno: #{@simbolo_branco.inspect}"
    log "DEBUG: Fita inicial: #{fita.inspect}"
    log "DEBUG: Iniciando simulação..."

    passo = 0
    decisao = nil

    while passo < @max_passos
      simbolo_atual = fita[posicao] || @simbolo_branco
      log "PASSO #{passo} - Estado atual: #{estado_atual.inspect} - Cabeçote: #{posicao} - Símbolo: #{simbolo_atual.inspect}"

      if @estados_aceitacao.include?(estado_atual)
        decisao = 'ACEITA'
        log "DEBUG: Estado atual '#{estado_atual}' é estado de aceitação."
        break
      end

      if @estados_rejeicao.include?(estado_atual)
        decisao = 'REJEITA'
        log "DEBUG: Estado atual '#{estado_atual}' é estado de rejeição."
        break
      end

      trans = encontrar_transicao(estado_atual, simbolo_atual)

      if trans.nil?
        log "DEBUG: Nenhuma transição encontrada para estado #{estado_atual.inspect} e símbolo #{simbolo_atual.inspect}"
        decisao = @estados_aceitacao.include?(estado_atual) ? 'ACEITA' : 'REJEITA'
        break
      end

      log "DEBUG: Aplicando transição: #{trans.inspect}"
      escrito = trans.simbolo_escrito
      escrito = @simbolo_branco if escrito == '_'
      fita[posicao] = escrito

      mov = trans.movimento.to_s.downcase
      case mov
      when 'd', 'r', 'right'
        posicao += 1
      when 'c', 'l', 'left'
        posicao -= 1
      when 'cc', 's', 'stay', 'n'
        # sem movimento
      else
        # desconhecido -> sem movimento
      end

      if posicao >= fita.length
        fita << @simbolo_branco
      end

      if posicao < 0
        fita.unshift(@simbolo_branco)
        posicao = 0
      end

      estado_atual = trans.estado_destino
      passo += 1
    end

    if decisao.nil?
      decisao = 'REJEITA'
      log "DEBUG: Limite de passos atingido (#{@max_passos}). Decidindo REJEITA por segurança."
    end

    log "DEBUG: Fita final: #{fita.inspect}"
    log "DEBUG: Estado final: #{estado_atual.inspect}"
    log "DEBUG: Decisão final: #{decisao.inspect}"

    puts "Decidiu? #{decisao}"
    puts "Fita da submáquina: #{fita.inspect}"

    decisao
  end
end

MTU = MaquinaTuringUniversal
