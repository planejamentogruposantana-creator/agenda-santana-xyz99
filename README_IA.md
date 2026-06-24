# Guia de Operação e Desenvolvimento – Calendário de Projetos (Jonas)

Este documento serve para guiar outras IAs sobre a arquitetura, regras de negócio e procedimentos de suporte para o projeto **Calendário de Projetos (Jonas)**.

---

## 📂 Localização do Projeto no Sistema

Todos os arquivos atualizados foram consolidados e estão disponíveis no drive **D:**:
- **Site Funcional Principal (Build do Claude):** [index.html](file:///D:/calendario-projetos/index.html) dentro de `D:\calendario-projetos\`
- **Repositório Git Completo (Histórico):** `D:\agenda jonas\`
- **Backup da Versão Online Estática:** `D:\agenda jonas.html`

---

## 🛠️ Arquitetura Técnica e Fluxo de Dados

O projeto é uma aplicação Single Page (SPA) baseada em HTML, Vanilla CSS e Javascript puro, contendo as seguintes características:

1. **Interface Visual:** Painel interativo estilo gráfico de Gantt moderno e responsivo, adaptado para desktop e mobile.
2. **Armazenamento de Dados:** 
   - **Banco de Dados Real (Nuvem):** Uma planilha pública do Google Sheets (formato CSV) configurada para publicação na Web.
   - **Banco de Dados Local:** Cache e edições locais salvas via `localStorage` do navegador para controle offline/persistência rápida.
3. **Sincronização:**
   - Ao iniciar, o app carrega o histórico do `localStorage`.
   - Um script de segundo plano (`autoRefresh()`) realiza requisições HTTP (`fetch`) para a URL da planilha a cada 30 segundos, integrando os dados novos (`mergeWithSheet`) sem apagar as alterações offline.

### 🔗 URL da Planilha de Origem (Google Sheets)
A planilha ativa vinculada é:
`https://docs.google.com/spreadsheets/d/e/2PACX-1vQbR1FrIBNJ6JC48-OJQ8PMEQ8RD5s4EvIDK8AxKNDkR8ra0bluT9oLMCsPApC4lrw89hGyu32oFjen/pub?output=csv`

---

## 📋 Regras de Negócio e Estrutura dos Projetos

Os dados importados da planilha esperam a seguinte estrutura de colunas (ou variações equivalentes mapeadas pelo parser):

* **nome (ou atividade/projeto):** Título descritivo da tarefa. (Obrigatório)
* **cliente:** Nome do cliente/empresa.
* **responsavel:** Geralmente atribuído ao `"Jonas"`.
* **inicio:** Data de início no formato `AAAA-MM-DD`.
* **prazo (ou fim):** Data limite no formato `AAAA-MM-DD`.
* **status:** Estado da atividade (`"em andamento"`, `"concluído"`, `"pendente"`).
* **progresso:** Porcentagem de conclusão (`0` a `100`).
* **descricao:** Detalhamento técnico da tarefa.

---

## 🚀 Orientações para Desenvolvimento Futuro (Próximas IAs)

Caso o usuário solicite alterações no calendário, siga este fluxo:

1. **Alterações nos Dados:**
   - Dê preferência a atualizar a planilha do Google Sheets vinculada acima. O app fará o auto-refresh e atualizará a visualização automaticamente no navegador.
   - Se for solicitado o desenvolvimento offline, edite diretamente o array `projects` no arquivo principal ou use o modal da interface.

2. **Alterações de Código/Funcionalidade:**
   - Trabalhe diretamente no arquivo [index.html](file:///D:/calendario-projetos/index.html).
   - Mantenha o design limpo usando as variáveis declaradas no `:root` CSS para garantir a identidade visual (tema escuro com detalhes em roxo/accent e alertas laranja).
   - Teste a responsividade no mobile (o arquivo possui seções dedicadas a listas condensadas para telas menores).

3. **Garantia de Persistência:**
   - Ao adicionar ou mesclar dados locais, certifique-se de que a função `persist()` (que gerencia o `localStorage`) seja chamada para não perder as atualizações do usuário após recarregar.
