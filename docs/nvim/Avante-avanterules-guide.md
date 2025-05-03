# Guia de Configuração de .avanterules para Avante.nvim

## Introdução

O Avante.nvim é um plugin para Neovim que oferece funcionalidades de codificação assistida por IA, inspirado no Cursor AI IDE. Ele permite personalizar o comportamento da IA por meio de arquivos `.avanterules`, que são modelos [Jinja](https://jinja.palletsprojects.com/en/stable/) usados para definir prompts em diferentes modos, como planejamento, edição e sugestão.

**Outline**

Este guia detalha:

- como configurar esses arquivos
- compara os `.avanterules` com os recursos [@Docs](https://docs.cursor.com/context/@-symbols/@-docs) e [.mdc](https://docs.cursor.com/context/rules#example-mdc-rule) do Cursor IDE
- fornece exemplos práticos
- lista todas as referências relevantes.

## O que são avanterules?

Os arquivos `.avanterules` são modelos _Jinja_ que personalizam os prompts enviados à IA do Avante.nvim.
Eles são nomeados com base no modo (ex.: planning, editing, suggesting) e, opcionalmente, no tipo de arquivo (ex.: typescript.planning.avanterules). Esses arquivos são colocados na raiz do projeto e detectados automaticamente pelo plugin com base no contexto do buffer atual.

### Características principais:

- **Flexibilidade:** Permitem definir instruções específicas para a IA, como seguir padrões de projeto ou otimizar código.
- **Modularidade:** Suportam herança de modelos base (ex.: base.avanterules) para reutilização.
- **Integração:** Funcionam com diferentes provedores de IA configurados no Avante.nvim.

## Passos para Configuraçã1.

Uma vez instalado e configurado o Avante.nvim podemos seguir os seguintes passos para a configuração e uso de .avanterules.

### 1. Criar Arquivos avanterules

Crie arquivos `.avanterules` na raiz do projeto com nomes que correspondam ao modo e, se necessário, ao tipo de arquivo. Por exemplo:

- `suggesting.avanterules`: Para sugestões gerais.
- `typescript.planning.avanterules`: Para planejamento em arquivos TypeScript.

Use a sintaxe Jinja para definir prompts. Veaj alguns exemplos:

**1. Prompt para Modo de Sugestão**

- **Arquivo:** `suggesting.avanterules`
- **Uso:** Garante que sugestões sejam claras e otimizadas.

```jinja
{% extends "base.avanterules" %}

{% block extra_prompt %}
Sempre forneça sugestões que melhorem a legibilidade e o desempenho do código. Priorize soluções que sigam as convenções do projeto.
{% endblock %}
```

**2. Prompt para Planejamento em TypeScript**

- **Arquivo:** `typescript.planning.avanterules`
- **Uso:** Orienta a IA a planejar código TypeScript com boas práticas.

```jinja
{% extends "base.avanterules" %}

{% block extra_prompt %}
Considere as melhores práticas do TypeScript ao planejar a estrutura do código. Inclua tipagem forte e evite any sempre que possível.
{% endblock %}
```

**3. Prompt para Modo de Edição**

- **Arquivo:** snippets.editing.avanterules
- **Uso:** Mantém edições alinhadas com o estilo do projeto.

```jinja
{% extends "base.avanterules" %}

{% block extra_prompt %}
Certifique-se de que todas as edições mantenham a consistência do código e sigam os padrões do projeto, como formatação e nomenclatura.
{% endblock %}
```

### 2. Estrutura do Projeto

O Avante.nvim verifica a raiz do projeto (geralmente onde está o `.git/`) para encontrar arquivos `.avanterules`. Exemplo de estrutura:

```
project_dir/
├── .git/
├── typescript.planning.avanterules
├── snippets.editing.avanterules
├── suggesting.avanterules
├── tests/
└── src/
```

### 3. Testar a Configuraçã1.

Abra um arquivo no Neovim e use comandos do Avante.nvim (ex.: `:AvanteSuggest`) para verificar se os prompts personalizados estão sendo aplicados. O plugin carrega automaticamente o arquivo `.avanterules` correspondente ao modo e tipo de arquivo.

## Comparação com Cursor IDE (@Docs e arquivos .mdc)

> Gerado com a ajuda da IA Grok 3.

O Cursor IDE oferece recursos como @Docs e .mdc para melhorar a experiência de codificação assistida por IA. Abaixo, uma comparação detalhada com os avanterules do Avante.nvim:

**@Docs no Cursor IDE**

- **Função:** Permite referenciar documentação externa diretamente no código, usando a sintaxe @LibraryName ou mencionando o nome do documento.
- **Exemplo:** Digitar @React pode trazer documentação oficial do React.
- **Uso:** Ideal para acessar rapidamente informações externas sem sair do IDE.
- **Integração:** Indexa links fornecidos pelo usuário no workspace (Cursor @Doc).

**.mdc no Cursor IDE**

- **Função:** Arquivos de regras MDC (Machine-Driven Code) que definem como a IA deve lidar com padrões de código ou fornecer sugestões.
- **Exemplo:** Um arquivo .mdc pode especificar como formatar código em um projeto Rails.
- **Uso:** Colocado no diretório .cursor/rules para personalizar o comportamento da IA (MDC Rules).
- **Flexibilidade:** Focado em regras estruturadas, mas menos dinâmico que prompts personalizados.

**avanterules no Avante.nvim**

- **Função:** Modelos Jinja que personalizam prompts para modos específicos (planejamento, edição, sugestão).
- **Exemplo:** Um arquivo editing.avanterules pode garantir que edições sigam padrões de projeto.
- **Uso:** Colocado na raiz do projeto, detectado automaticamente pelo plugin.
- **Flexibilidade:** Altamente personalizável, mas exige conhecimento de Jinja e configuração manual.

### Principais Diferenças

- **Foco:** avanterules são voltados para prompts dinâmicos, enquanto @Docs foca em documentação e .mdc em regras fixas.
- **Integração:** @Docs e .mdc são mais integrados ao fluxo do Cursor IDE, enquanto avanterules exigem configuração explícita.
- **Complexidade:** avanterules oferecem maior controle, mas demandam mais esforço para configurar comparado à simplicidade de @Docs.

## Benefícios e Limitações

**Benefícios**

- **Personalização Avançada:** avanterules permitem adaptar a IA a necessidades específicas do projeto.
- **Integração com Neovim:** Ideal para usuários que preferem o fluxo de trabalho do Neovim.
- **Suporte a Múltiplos Provedores:** Funciona com diferentes APIs de IA, como OpenAI ou Claude.

**Limitações**

- **Curva de Aprendizado:** Configurar Jinja requer conhecimento técnico.
- **Falta de Integração Direta:** Não suporta @Docs ou .mdc, exigindo soluções alternativas para documentação externa.
- **Dependência de Configuração Manual:** Diferente do Cursor IDE, que automatiza mais processos.

## Links uteis sobre avanterules e cursor IDE.

[Avante.nvim Wiki](https://github.com/yetone/avante.nvim/wiki)
[Avante.nvim Templates](https://github.com/yetone/avante.nvim/blob/main/lua/avante/templates)
[Cursor AI IDE Features](https://www.cursor.com/en/features)
[Cursor AI IDE Documentation](https://docs.cursor.com/)
[MDC Rules in Cursor Forum](https://forum.cursor.com/t/my-best-practices-for-mdc-rules-and-troubleshooting/50526)
[Exploring Cursor @Doc Feature](https://www.rudrank.com/exploring-cursor-accessing-external-documentation-using-doc/)

