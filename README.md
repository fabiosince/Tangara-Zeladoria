# Tangará Zeladoria V49

V49 amplia o acesso individual da V48 com gestão local de usuários.

## Novidades
- Login individual por usuário e senha.
- Troca de senha pelo próprio usuário.
- Síndico pode criar usuários.
- Síndico pode ativar/desativar usuários.
- Síndico pode redefinir senha de usuários.
- Morador continua com acesso somente às funções permitidas.
- Colaborador mantém o fluxo operacional.
- Painel e Service Worker atualizados para V49.

## Observação de segurança
A autenticação desta versão continua local no navegador/localStorage porque o projeto está em GitHub Pages. Ela é adequada para protótipo/uso controlado no dispositivo, mas não deve ser tratada como autenticação de produção. Para produção, a próxima etapa deve migrar contas, sessões e senhas para um backend de autenticação.
