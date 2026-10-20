Uso do agente primário (mimo-ultra)

Arquivos adicionados:
- .primary-agent: configuração com o repositório e caminho do arquivo do agente
- fetch-primary-agent.ps1: script que clona/atualiza o repositório e copia `mimo-ultra.md` para a raiz do workspace

Como usar (manual):
1. No Windows PowerShell, execute: .\fetch-primary-agent.ps1
2. O script vai clonar o repositório configurado em `.primary-agent-repo` e copiar `mimo-ultra.md` para a raiz do projeto.

Automação recomendada:
- Rodar `fetch-primary-agent.ps1` antes de iniciar uma conversa, ou integrar ao seu fluxo de inicialização para garantir que o agente esteja sempre presente.

Observação:
- O repositório remoto já foi criado em https://github.com/AllenDevv/mimo-ultra-agent e contém `mimo-ultra.md`.
