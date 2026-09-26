# Tangará Zeladoria V18

V18 corrige o vínculo automático de materiais às ocorrências.

## Materiais
- Ao abrir uma ocorrência, o sistema identifica materiais prováveis pelo título e descrição.
- Se nenhum material foi adicionado manualmente, os materiais sugeridos são vinculados automaticamente ao salvar.
- O usuário pode editar quantidade/unidade, remover e adicionar materiais antes do registro.
- A ocorrência mantém a lista de materiais vinculada.
- Histórico permite consultar os materiais da ocorrência.
- Banco de materiais consolida as quantidades e permite exportação CSV e JSON.

## Fluxo de teste
1. Abra Nova ocorrência.
2. Título: `Lâmpada queimada`.
3. Salve sem adicionar material manualmente.
4. Verifique no histórico: `Materiais necessários: 1` e `Lâmpada LED — 1 un`.
5. Abra os materiais da ocorrência para conferir o vínculo.
6. Acesse Mais > Banco de materiais e teste CSV/JSON.
