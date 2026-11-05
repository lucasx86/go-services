# GO Services! 🛠️📍

**Aplicativo acadêmico de contratação de serviços locais — planejamento do MVP em Dart/Flutter.**

O **GO Services!** pretende conectar clientes a prestadores de serviços da região (eletricistas, encanadores, mecânicos, profissionais de limpeza e manutenção), facilitando a busca por categoria e proximidade, a consulta a perfis e avaliações e o envio de solicitações de atendimento.

> **Status atual:** planejamento, backlog e protótipos. A existência das issues não significa que as funcionalidades estejam implementadas.

## 🎯 Objetivo e público

- **Cliente:** encontrar profissionais, consultar perfil e reputação, enviar um pedido e acompanhar a resposta.
- **Prestador:** divulgar especialidades e área de atuação, receber, aceitar ou recusar solicitações e construir reputação.
- **Prioridade:** lançar um MVP utilizável, documentado e respeitando privacidade e autorização de localização.

## 🧰 Stack prevista

| Camada | Tecnologia / decisão |
| --- | --- |
| Aplicativo Android | **Dart + Flutter** |
| Design e protótipos | Figma |
| Backend, autenticação e banco de dados | **A definir com a equipe** |
| Gestão de tarefas | GitHub Issues |
| Versionamento e revisão | Git + pull requests |

## 📱 As cinco telas planejadas

1. Acesso / Login
2. Início: categorias, busca e profissionais próximos
3. Perfil público do profissional
4. Solicitação de atendimento
5. Painel do prestador: pedidos, aceite e recusa

**Referências de design:**
- [Figma — primeiras três telas](https://www.figma.com/design/b20xDVSPDRzxNLaTPDW0eE)
- [Figma — arquivo separado das telas 4 e 5](https://www.figma.com/design/g7UVaS4yl5epnVJ03SH7xL) — arquivo criado; os layouts ainda precisam ser importados nele.

## ✅ Escopo do MVP

- Cadastro, login e perfis de clientes e prestadores.
- Catálogo de categorias, pesquisa, filtros e listagem de profissionais.
- Geolocalização **com permissão**, oferecendo busca manual caso o usuário negue.
- Perfis profissionais, solicitação de atendimento, aceite/recusa e acompanhamento.
- Meio de contato associado à solicitação.
- Avaliações permitidas **somente após serviços concluídos**.

**Fora do MVP inicial:** pagamento integrado, comissões, rastreamento em tempo real, seguros e verificação avançada. Notificações são uma evolução condicional.

## 🗂️ Planejamento no GitHub

- **[Backlog completo — 30 issues](https://github.com/lucasx86/go-services/issues)**
- [Roadmap do projeto](docs/ROADMAP.md)
- [Critérios de conclusão](docs/DEFINITION_OF_DONE.md)
- [Guia de colaboração](CONTRIBUTING.md)
- [Rastreabilidade com requisitos](docs/RASTREABILIDADE.md)

As issues seguem códigos como **PL-01** (planejamento), **FL-01** (Flutter), **SO-01** (solicitações) e **QA-01** (testes). No corpo de cada uma constam área, fase, prioridade e critérios de aceite. P0 = essencial, P1 = importante, P2 = evolução.

## 🤝 Organização da equipe

Cada integrante deve escolher/receber uma issue, criar uma branch por tarefa, enviar um pull request para revisão e fechar a issue somente depois de validar os critérios de aceite. Consulte [CONTRIBUTING.md](CONTRIBUTING.md).

## 📄 Referência dos requisitos

**Documento de Requisitos de Software — GO Services!, versão 1.0 (29/10/2026).** O backlog foi organizado em torno de RF01–RF15, RN01–RN07 e RNF01–RNF10. As tecnologias e funcionalidades futuras são decisões/propostas de implementação e não substituem o DRS.
