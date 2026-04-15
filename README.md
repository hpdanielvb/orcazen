# OrcaZen

Sistema financeiro baseado em ledger contábil com inteligência, simulação e automação.

## Objetivo

Construir um sistema financeiro robusto, auditável e determinístico, capaz de:

- Controlar finanças pessoais
- Simular cenários futuros
- Automatizar decisões financeiras
- Garantir consistência contábil (ledger)

## Arquitetura

- Ledger como fonte única da verdade
- Snapshot engine para reconstrução
- Transfer engine para neutralização interna
- Simulation engine para projeções

## Estrutura

- docs → documentação e decisões
- core → regras e motores
- sql → estrutura do banco
- prompts → integração com IA
- patches → evolução do sistema
- backlog → planejamento

## Regras fundamentais

- Nenhuma regra fica fora do repositório
- Toda mudança gera um patch
- Nada sobrescreve histórico
