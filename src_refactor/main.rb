#!/usr/bin/env ruby
# src_refactor/main.rb
# Script principal que carrega uma máquina (.mt) e uma entrada (.in)
require 'pathname'

if ARGV.length < 2
  puts "Uso: ruby #{__FILE__} caminho_para_maquina.mt caminho_para_entrada.in"
  exit 1
end

caminho_mt = ARGV[0]
caminho_in = ARGV[1]

begin
  mt_path = Pathname.new(caminho_mt).realpath rescue Pathname.new(caminho_mt).expand_path
  puts "DEBUG: Carregando máquina de: #{mt_path}"
  require_relative 'maquina_turing_universal'
  mtu = MaquinaTuringUniversal.new
  mtu.processar(mt_path.to_s, caminho_in)
rescue LoadError => e
  puts "Erro ao carregar arquivos: #{e.message}"
  puts e.backtrace.join("\n")
  exit 1
rescue => e
  puts "Erro durante a execução: #{e.message}"
  puts e.backtrace.join("\n")
  exit 1
end
