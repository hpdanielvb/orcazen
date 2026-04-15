# Arquitetura OrcaZen

## Visão Geral

O OrcaZen evolui de um modelo baseado em transações para um modelo baseado em ledger contábil.

## Modelo Atual

- transactions (origem operacional)
- journal_entries
- journal_lines

## Problema

transactions ainda é utilizada como fonte principal, causando inconsistência.

## Solução

Migrar para arquitetura ledger-first.

## Componentes

### Ledger Engine
Responsável por garantir consistência contábil.

### Snapshot Engine
Reconstrói estado financeiro em qualquer ponto no tempo.

### Transfer Engine
Neutraliza transferências internas entre contas.

### Simulation Engine
Permite projeção de cenários futuros.

## Diretriz

Ledger será a única fonte de verdade após estabilização.
