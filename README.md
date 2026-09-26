# Tangará Zeladoria V53.1 — Fundação Central

A V53.1 parte do código visual/funcional da V51 e prepara a arquitetura para uso multi-dispositivo.

## O que foi preservado
- Identidade Tangará Residencial e fundo fornecido.
- Perfis Síndico, Colaborador e Morador.
- Status de ocorrência: Aberta / Resolvida.
- Reabertura de ocorrência.
- Pendências, checklist, materiais, histórico e exportações.
- Regras de acesso já definidas no aplicativo.

## O que entra nesta etapa
- Estrutura PostgreSQL central em `supabase-schema.sql`.
- Modelo de autenticação central baseado no Supabase Auth.
- Perfis ligados ao condomínio.
- Ocorrências, materiais, inspeções e compras preparados para dados compartilhados.
- Fotos preparadas para armazenamento em bucket privado.
- `supabase-config.example.js` como configuração inicial.

## Importante
Esta entrega é a fundação do backend. O aplicativo ainda permanece em modo local até que o projeto Supabase seja criado e configurado. Não coloque uma chave de serviço (service_role) no aplicativo.

## Próximo passo
1. Criar um projeto Supabase.
2. Executar `supabase-schema.sql` no SQL Editor.
3. Criar o bucket privado `occurrence-photos`.
4. Configurar `supabase-config.js` a partir do exemplo.
5. Na V53.2, ligar login, ocorrências, inspeções, materiais e fotos à API central.

## Teste atual
O login local continua disponível enquanto o backend não estiver conectado. Isso evita bloquear os testes do aplicativo durante a migração.
