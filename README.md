# Tangará Zeladoria V46

Correção e reforço do fluxo de pendências para Colaborador e Síndico.

- Pendências separadas por status Aberta/Resolvida e Área.
- Colaborador entra em Pendências com Aberta selecionada.
- “Ver / editar pendência” abre a ocorrência específica no formulário de edição.
- O botão usa evento centralizado (`data-edit-occurrence`), sem `onclick` inline.
- Modo edição mostra identificação visual e botão “Cancelar edição”.
- Salvar alterações atualiza a pendência existente e não cria duplicata.
- Edição preserva ID, data, usuário e status; atualiza área, título, prioridade, descrição e foto.
- Morador permanece somente leitura.
- Materiais permanecem sob controle do Síndico.
- Service Worker/cache V46.


V46: correção do fluxo de baixa/reabertura com eventos delegados e ações também na lista de Pendências.
