# Tangará Zeladoria V44

Refatoração do fluxo de pendências e edição de ocorrências.

- Pendências separadas por status Aberta/Resolvida e Área.
- Colaborador entra em Pendências com Aberta selecionada.
- “Ver / editar” abre a ocorrência específica no formulário de edição.
- Edição preserva ID, data, usuário e status; atualiza área, título, prioridade, descrição e foto.
- Morador permanece somente leitura.
- Materiais permanecem sob controle do Síndico.
- Estados do formulário novo/edição centralizados para evitar vazamento de modo.
- Service Worker/cache V43.
