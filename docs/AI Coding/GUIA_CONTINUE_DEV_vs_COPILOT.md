# Guia Alternativo: VSCode com Continue.dev vs. GitHub Copilot

Este documento serve como um guia para utilizar o `Continue.dev` no VSCode, oferecendo um plano para as mesmas tarefas do guia anterior e um comparativo direto com o GitHub Copilot.

`Continue.dev` é uma extensão open-source que transforma seu IDE em uma ferramenta de desenvolvimento assistida por LLMs, com foco em flexibilidade, privacidade e customização.

## 1. Plano de Tarefas com Continue.dev

A configuração do `Continue.dev` é centralizada em um único arquivo Python (`~/.continue/config.py`), o que permite um controle muito granular.

**Passo-a-passo geral:**

1.  Instale a extensão `Continue` a partir do VSCode Marketplace.
2.  Abra o painel do Continue e clique no ícone de engrenagem ou use o comando `Ctrl/Cmd + L` e digite `> config` para abrir o arquivo `config.py`.
3.  Edite o arquivo `config.py` com as configurações desejadas.

---

### a. Configurando com OpenRouter

Adicione um modelo do OpenRouter à lista de modelos no seu `config.py`.

```python
from continuedev.core.config import Config
from continuedev.core.models import Models
from continuedev.libs.llm.openrouter import OpenRouter

# ... outras importações

config = Config(
    models=Models(
        default=OpenRouter(
            api_key="YOUR_OPENROUTER_API_KEY",
            model="mistralai/mistral-7b-instruct-free" # Ou outro modelo de sua escolha
        )
    )
)
```

### b. Configurando com Ollama (Local e WSL)

Execute modelos na sua própria máquina para ter total privacidade e zero custo de API.

```python
from continuedev.core.config import Config
from continuedev.core.models import Models
from continuedev.libs.llm.ollama import Ollama

# ...

config = Config(
    models=Models(
        default=Ollama(model="codellama") # Garanta que o modelo foi baixado com `ollama pull codellama`
    )
)
```
**Para WSL:** O princípio é o mesmo. Se o seu servidor Ollama estiver rodando dentro do WSL, o `Continue.dev` (rodando no VSCode conectado ao WSL) irá encontrá-lo em `localhost` sem configurações adicionais.

### c. Configurando com um Proxy

`Continue.dev` respeita variáveis de ambiente padrão como `HTTP_PROXY` e `HTTPS_PROXY`. Alternativamente, você pode especificar uma `api_base` para provedores que a suportam.

**Método 1: Variáveis de Ambiente (Recomendado)**

No seu terminal, antes de iniciar o VSCode:
```bash
export HTTPS_PROXY="http://SEU_PROXY_HOST:PORTA"
code .
```

**Método 2: `api_base` (Para OpenAI e compatíveis)**

```python
from continuedev.core.config import Config
from continuedev.core.models import Models
from continuedev.libs.llm.openai import OpenAI

# ...

config = Config(
    models=Models(
        default=OpenAI(
            api_key="YOUR_OPENAI_API_KEY",
            model="gpt-4o",
            api_base="https://SUA_URL_DE_PROXY/v1" # Endereço do proxy
        )
    )
)
```

## 2. Comparativo: Continue.dev vs. GitHub Copilot

| Característica | GitHub Copilot | Continue.dev |
| :--- | :--- | :--- |
| **Modelos Suportados** | Modelos proprietários da OpenAI (GPT-3.5, GPT-4) otimizados pela Microsoft. | Quase qualquer modelo: Ollama, OpenAI, Gemini, Claude, OpenRouter, etc. |
| **Custo** | Assinatura paga (mensal/anual). | A extensão é gratuita. O custo é o da API do modelo que você escolher (ou zero, se usar Ollama local). |
| **Código-Fonte** | Fechado. | **Aberto (Open-Source)**. |
| **Privacidade** | O código é enviado aos servidores da Microsoft (com políticas de privacidade). | **Controle total.** Com modelos locais (Ollama), nada sai da sua máquina. |
| **Customização** | Baixa. Algumas opções de configuração e exclusão de arquivos. | **Extremamente alta.** Configuração via Python, criação de comandos (`/slash_commands`), customização de contexto. |
| **Gerenciamento de Contexto** | Automático, baseado nos arquivos abertos. | **Explícito e poderoso.** Use `@` para adicionar arquivos, pastas, documentação, problemas do GitHub e mais ao contexto. |
| **Interface do Usuário** | Foco em autocompletar *inline*. Um painel de chat separado (`Copilot Chat`). | Foco no painel de chat interativo, com autocompletar *inline* como um recurso complementar. |
| **Configuração Inicial**| "Funciona ao ligar" (Out-of-the-box). Praticamente nenhuma configuração. | Requer configuração inicial no arquivo `config.py` para escolher e autenticar seus modelos. |


## 3. Plano de Migração: Do Copilot para o Continue.dev

Migrar é um processo simples e direto:

1.  **Instale o Continue.dev:** Procure por "Continue" no VSCode Marketplace e instale a extensão.
2.  **Desabilite o GitHub Copilot:** Para evitar conflitos de atalhos e sugestões duplicadas, é altamente recomendado desabilitar ou desinstalar as extensões `GitHub Copilot` e `GitHub Copilot Chat`. Vá para a aba de Extensões, encontre o Copilot e clique em `Disable (Workspace)`.
3.  **Configure seu Primeiro Modelo:** Siga as instruções da **Seção 1** deste guia para configurar seu `config.py` com o provedor de sua escolha (Ollama é um ótimo ponto de partida por ser gratuito e local).
4.  **Aprenda o Fluxo de Trabalho:**
    *   Use `Ctrl + L` para abrir a caixa de diálogo do Continue.
    *   Use `Ctrl + J` (ou o atalho que configurar) para abrir o painel de chat.
    *   Digite `/` no chat para ver os comandos disponíveis (ex: `/edit`, `/fix`, `/test`).
    *   Digite `@` para ver os provedores de contexto (ex: `@file`, `@terminal`, `@docs`).

## 4. Análise: Ganhos e Perdas na Migração

### O que você GANHA com a migração para o Continue.dev:

1.  **Flexibilidade Total:** Você não fica preso a um único provedor. Pode usar o melhor modelo para cada tarefa, seja ele open-source, da Google, Anthropic ou OpenAI.
2.  **Controle Absoluto e Privacidade:** A capacidade de rodar 100% localmente com Ollama é um ganho imenso para empresas com políticas de privacidade restritas ou para desenvolvedores que não querem que seu código saia da máquina.
3.  **Potencial de Custo Zero:** Ao usar modelos locais, o único custo é o do seu próprio hardware.
4.  **Customização Profunda:** A capacidade de criar seus próprios comandos e automatizar fluxos de trabalho no `config.py` permite adaptar a ferramenta exatamente às suas necessidades.
5.  **Gerenciamento de Contexto Superior:** O sistema de `@` do Continue é mais explícito e poderoso que o gerenciamento automático do Copilot, permitindo que você construa um contexto muito preciso para o LLM.

### O que você PERDE (ou o que muda):

1.  **A Experiência "Mágica" do Autocomplete:** O autocompletar *inline* do GitHub Copilot é extremamente polido e bem integrado. Embora o Continue.dev também ofereça autocomplete, a experiência do Copilot é frequentemente considerada o padrão ouro em termos de fluidez.
2.  **Simplicidade "Out-of-the-Box":** O Copilot exige quase zero configuração. O Continue.dev tem uma curva de aprendizado inicial, exigindo que você configure seu primeiro modelo no `config.py`.
3.  **Modelo "Tudo-em-Um" Otimizado:** Com o Copilot, você recebe um modelo de alta qualidade que a Microsoft otimizou para tarefas de codificação. Com o Continue, a qualidade da assistência depende inteiramente do modelo que *você* escolhe e configura.
