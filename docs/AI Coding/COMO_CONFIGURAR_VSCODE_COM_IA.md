# Guia: Configurando o VSCode com Modelos de IA (OpenRouter, Ollama e Proxy)

Este guia detalha como configurar o Visual Studio Code para usar diferentes provedores de modelos de linguagem (LLMs) para assistência de codificação, aproveitando a funcionalidade nativa "Bring Your Own Key" (BYOK).

## 1. Configurando com OpenRouter

O OpenRouter oferece acesso a uma vasta gama de modelos de diferentes provedores através de uma única API.

**Passo-a-passo:**

1.  **Obtenha a API Key:**
    *   Acesse o site do [OpenRouter](https://openrouter.ai/).
    *   Faça login e navegue até a sua página de "Keys" para criar ou copiar sua chave de API.

2.  **Configure o VSCode:**
    *   Abra o VSCode e vá para as configurações em JSON (`Ctrl + Shift + P` e procure por `Preferences: Open User Settings (JSON)`).
    *   Adicione o seguinte bloco de configuração ao seu `settings.json`, substituindo `"MODELS_HERE"` pelos modelos que deseja usar (ex: `"mistralai/mistral-7b-instruct-free"`) e `"YOUR_OPENROUTER_API_KEY"` pela sua chave.

    ```json
    "github.copilot.languageModels": [
      {
        "provider": "openrouter",
        "model": "MODELS_HERE", // Ex: "mistralai/mistral-7b-instruct-free" ou "google/gemini-flash-1.5"
        "apiKey": "YOUR_OPENROUTER_API_KEY",
        "url": "https://openrouter.ai/api/v1"
      }
    ]
    ```

    *   **Nota:** Você pode adicionar vários modelos e alternar entre eles diretamente no VSCode.

## 2. Configurando com Ollama (Local e WSL)

Ollama permite que você execute modelos de linguagem open-source diretamente na sua máquina.

### a. Ollama Local (Linux/macOS)

1.  **Instale o Ollama:** Siga as instruções de instalação no [site oficial do Ollama](https://ollama.com/).
2.  **Baixe um Modelo:** Abra seu terminal e baixe um modelo de codificação.
    ```bash
    ollama pull codellama
    ```
3.  **Configure o VSCode:** Adicione a seguinte configuração ao seu `settings.json`. O Ollama, por padrão, roda em `http://localhost:11434`.

    ```json
    "github.copilot.languageModels": [
      {
        "provider": "ollama",
        "model": "codellama", // Ou qualquer outro modelo que você baixou
        "url": "http://localhost:11434"
      }
    ]
    ```

### b. Ollama no Windows com WSL (Windows Subsystem for Linux)

A maneira mais fácil e recomendada é rodar o VSCode diretamente de dentro do ambiente WSL.

1.  **Instale o Ollama no WSL:** Abra seu terminal WSL e instale o Ollama seguindo as instruções para Linux.
2.  **Baixe um Modelo no WSL:**
    ```bash
    ollama pull deepseek-coder
    ```
3.  **Abra o VSCode no WSL:** No seu terminal WSL, navegue até a pasta do seu projeto e digite `code .`. Isso abrirá o VSCode conectado ao ambiente WSL.
4.  **Configure o VSCode (mesmo que local):** Como o VSCode está rodando "dentro" do WSL, o `localhost` se refere ao próprio WSL. A configuração no `settings.json` é idêntica à de um ambiente Linux nativo.

    ```json
    "github.copilot.languageModels": [
      {
        "provider": "ollama",
        "model": "deepseek-coder",
        "url": "http://localhost:11434"
      }
    ]
    ```

## 3. Rodando com um Proxy (Ex: OpenAI)

Se você está atrás de uma VPN ou firewall que bloqueia o acesso direto a serviços como OpenAI, você pode configurar o VSCode para usar um proxy.

1.  **Configure o Proxy no VSCode:** Adicione a seguinte configuração global ao seu `settings.json`, substituindo pelo endereço e porta do seu proxy.

    ```json
    "http.proxy": "http://SEU_PROXY_HOST:PORTA"
    ```

2.  **Configure o Provedor de Modelo:** Agora, configure o provedor do modelo (como OpenAI) normalmente. O VSCode automaticamente roteará a requisição através do proxy configurado.

    ```json
    "github.copilot.languageModels": [
      {
        "provider": "openai",
        "model": "gpt-4o",
        "apiKey": "YOUR_OPENAI_API_KEY"
      }
    ]
    ```
    *   **Importante:** A configuração de `languageModels` não possui um campo de proxy próprio; ela respeita a configuração `http.proxy` global do VSCode.

## 4. Recomendações de Hardware para Ollama

O desempenho do Ollama depende principalmente da **RAM** (para carregar o modelo) e da **VRAM** (memória da GPU, para processamento rápido).

*   **RAM Mínima:**
    *   **8 GB:** Suficiente para modelos de ~3 bilhões (3B) de parâmetros com quantização (ex: `phi-3`).
    *   **16 GB:** Recomendado para modelos de 7B (ex: `codellama:7b`, `llama3:8b`). Essa é a configuração mais comum e com melhor custo-benefício.
    *   **32 GB+:** Necessário para modelos de 13B ou maiores (ex: `codellama:34b`).

*   **GPU (Altamente Recomendado):**
    *   **NVIDIA:** A melhor opção devido ao suporte CUDA. Uma GPU com **8 GB de VRAM** é um bom ponto de partida para modelos de 7B. Para modelos maiores ou processamento mais rápido, 12 GB, 16 GB ou mais são ideais.
    *   **AMD / Apple Silicon:** O Ollama tem um bom suporte para GPUs AMD (via ROCm) e para o Metal da Apple, tornando MacBooks com chips M1/M2/M3 excelentes máquinas para rodar modelos localmente.

## 5. Sugestões de Modelos Open-Source (Ollama)

*   **Para Codificação (Coding):**
    *   `codellama`: Um clássico, treinado especificamente para código.
    *   `deepseek-coder`: Frequentemente no topo dos benchmarks de codificação. É uma escolha excelente e muito poderosa.
    *   `starcoder2`: A nova geração do Starcoder, com bom desempenho em várias linguagens.
    *   `phi-3`: Um modelo menor da Microsoft, surpreendentemente capaz para seu tamanho e ótimo para máquinas com menos recursos.

*   **Para Chat e Dúvidas Gerais (Chat):**
    *   `llama3`: O Llama 3 da Meta é um dos melhores modelos de chat geral disponíveis hoje. A versão 8B é rápida e muito coerente.
    *   `mistral`: Rápido e de alta qualidade, uma alternativa excelente ao Llama.
    *   `qwen2`: Um modelo recente com forte capacidade multilíngue e bom raciocínio.

*   **Qual modelo mais se aproxima do "Claude Code"?**
    O "Claude 3 Opus" é um modelo proprietário de ponta, e igualá-lo com open-source é difícil, mas o que mais se aproxima em termos de capacidade de raciocínio complexo sobre código é provavelmente o **`deepseek-coder:33b`**. Ele é amplamente reconhecido pela sua performance de alto nível em tarefas de programação. Para uma experiência mais leve, mas ainda muito forte, o **`deepseek-coder:6.7b`** também é uma aposta fantástica.
