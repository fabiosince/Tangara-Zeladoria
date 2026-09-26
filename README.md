# Tangará Zeladoria V53.2 — Sistema Central Conectável

A V53.2 transforma a fundação da V53.1 em uma aplicação preparada para autenticação e sincronização reais com Supabase, mantendo o modo local como fallback enquanto o backend não estiver configurado.

## O que entra nesta versão

- Login central via Supabase Auth (e-mail + senha).
- Sessão persistente entre Android, iPhone e navegador.
- Perfil central: Síndico, Colaborador ou Morador.
- Carregamento central de ocorrências, materiais, inspeções e compras.
- Criação/edição de ocorrências no banco central.
- Dar baixa e reabrir ocorrências no banco central.
- Checklist/inspeções gravados no banco central.
- Materiais de ocorrência gravados no banco central.
- Compras sincronizadas para o perfil Síndico.
- Fotos de ocorrências preparadas para bucket privado `occurrence-photos`.
- Senha alterada pelo Supabase Auth.
- PWA/cache atualizado para V53.2.

## Como ativar o modo central

1. Crie um projeto no Supabase.
2. Abra o SQL Editor e execute `supabase-schema.sql` completo.
3. Crie um bucket privado chamado `occurrence-photos`.
4. Crie o condomínio em `public.condominiums`.
5. Crie os usuários em **Authentication → Users** usando e-mail e senha.
6. Para cada usuário criado, insira seu perfil em `public.profiles`, usando o mesmo UUID do usuário Auth. Exemplo:

```sql
insert into public.profiles (id, condominium_id, username, full_name, role)
values (
  'UUID_DO_USUARIO_AUTH',
  'UUID_DO_CONDOMINIO',
  'nome.usuario',
  'Nome do Usuário',
  'Colaborador'
);
```

7. Copie `supabase-config.example.js` para `supabase-config.js` e informe a URL e a chave **anon/public**.
8. Publique os arquivos no mesmo domínio do PWA.

## Login

No modo central, a tela de login usa **e-mail + senha** porque a autenticação é feita pelo Supabase Auth. O campo `username` continua existindo no perfil para identificação dentro do aplicativo.

## Segurança

- Nunca coloque `service_role` no aplicativo.
- O acesso aos dados depende do usuário autenticado e das políticas RLS.
- Morador pode criar ocorrência, mas não editar ocorrência existente, materiais ou inspeções.
- Colaborador pode operar ocorrências e checklist.
- Síndico possui acesso gerencial e às exportações.

## Importante sobre usuários

No modo central, criação, ativação/desativação e redefinição de senha devem ser feitas pelo fluxo administrativo do Supabase. O aplicativo não guarda senhas locais quando o backend está ativo.

## Fallback local

Enquanto `supabase-config.js` estiver com `enabled: false`, o aplicativo continua funcionando no modo local para testes. Esse modo não compartilha dados entre dispositivos e não deve ser tratado como produção.

## Próximo passo

**V53.3 — migração assistida dos dados locais existentes e teste de sincronização em dois celulares.**
