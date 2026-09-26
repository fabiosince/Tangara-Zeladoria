# Tangará Zeladoria V20

Aplicativo web para inspeções, ocorrências e controle de materiais de reposição.

## V20
- Somente os status **Aberta** e **Resolvida**.
- Materiais de reposição identificados automaticamente pela ocorrência.
- Ocorrência "Lâmpada queimada" sugere/registra **Lâmpada LED — 1 un**.
- Materiais podem ser editados na abertura e no histórico.
- É possível adicionar/remover materiais por ocorrência.
- Banco consolidado por material, quantidade e unidade.
- Exportação do banco em CSV e JSON.
- Migração de registros antigos: "Lâmpada" é normalizada para "Lâmpada LED".
- Dados permanecem armazenados no aparelho via localStorage.
