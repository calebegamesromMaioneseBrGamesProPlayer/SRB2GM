# AVISO AINDA ESTÁ EM FASE DE TESTE

# Sonic Robo Blast 2: God Mode

Esta versão foi reorganizada para ficar mais limpa e com um foco maior em um God Mode jogável.

## O que mudou

- O voo foi reforçado para fazer o Sonic subir com liberdade.
- O addon continua modular e compatível com mapas carregados dinamicamente.
- O fluxo principal foi simplificado para facilitar futuras integrações com a API do SRB2.

## Estrutura

- main.lua: ponto de entrada do addon.
- menu.lua: sistema de menu com F1 e navegação.
- powers.lua: implementação dos poderes do God Mode.
- debug.lua: funções de debug e spawn.
- teleport.lua: sistema de checkpoint e teleporte.
- hud.lua: HUD simples com status do addon.
- config.lua: estado global e configurações.

## Como usar

1. Coloque a pasta SRB2GodMode dentro da pasta de addons do SRB2.
2. Garanta que o addon seja carregado pelo SRB2.
3. Use F1 para abrir o menu.
4. Ative o poder de Voo livre para fazer o Sonic voar.

## Observações

Algumas funções ainda usam placeholders para manter a compatibilidade com diferentes builds do SRB2.
Em uma implementação mais avançada, elas podem ser trocadas por funções nativas do motor.
