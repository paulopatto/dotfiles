# Configurações para Continue.dev


## Visão geral
A configuração do Continue.dev usa principalmente o diretório `~/.continue`, com arquivos como `config.json` || `config.ts` ou `config.yaml` para modelos, MCPs e assistentes, compatível com meu setup de symlink compartilhado no Linux/Mac ou WSL/Windows.

A estrutura base é:

```text
continue/
└── .continue/          # Symlink para ~/.continue
    ├── config.json     # Sua config global (MCPs, Ollama, etc.)
    └── config.yaml     # Alternativa YAML para agents/customizações
```

## Configuração Stow

> Use `--adopt` se arquivos existentes conflitam: `stow --adopt -t ~ continue` para adotar e versionar.


```bash
cd $DOTFILES_HOME
stow --adopt -t continue  # Cria ~/.continue -> $DOTFILES_HOME$/continue/.continue
```

## Ollama

Algumas configs aquo fazem uso de modelos locais ollama evitando uso de tokens desnecessários na nuvem e abrindo possibilidade de uso completamente offline para seu "VibeCoding".

### Manual Rápido de Instalação do Ollama

#### 📋 Pré-requisitos

- Linux: Sistema moderno (Ubuntu 22.04+, Fedora 38+, etc.)
- Mac: macOS 12.3+ (Monterey ou superior)
- Windows: WSL2 instalado e configurado
- Requisitos mínimos de RAM: 8GB recomendado (4GB mínimo para modelos pequenos)

#### 🐧 Linux (Ubuntu/Debian)


**Script de instalação (recomendado)**

```bash
# Baixar e executar o script de instalação
curl -fsSL https://ollama.com/install.sh | sh

# Iniciar o serviço ollama (se não iniciar automaticamente)
sudo systemctl start ollama # Variantes do debian como o Ubuntu

# Habilitar inicialização automática
sudo systemctl enable ollama

# Verificar versão
ollama --version

# Verificar status do serviço
sudo systemctl status ollama
```

#### 🍎 macOS

**Método 1: Download via site (mais fácil)**

1. Acesse ollama.com
2. Clique em "Download for macOS"
3. Arraste o Ollama.app para a pasta Applications
4. Execute o aplicativo

**Método 2: Instalação via linha de comando com Homebrew**

```bash
# Instalar via Homebrew
brew install ollama

# Iniciar o serviço
brew services start ollama

# Ou iniciar manualmente
ollama serve
```

#### 🪟 Windows (via WSL2)

**Passo 1: Configurar WSL2 (se ainda não tiver)**

```bash
# Abra PowerShell como Administrador e execute:
wsl --install

# Ou especifique uma distribuição (recomendo Ubuntu)
wsl --install -d Ubuntu

# Verificar versão do WSL
wsl --version
```

**Passo 2: Instalar Ollama no WSL**

```bash
# No terminal WSL (Ubuntu/Debian)
curl -fsSL https://ollama.com/install.sh | sh

# Iniciar o serviço
sudo systemctl start ollama

# Habilitar na inicialização
sudo systemctl enable ollama
```

**Passo 3: Configurar acesso do Windows ao Ollama**

```pwsh
# No WSL, encontrar o IP
hostname -I

# No Windows, testar conexão (substitua IP pelo IP do WSL)
# No PowerShell:
# Test-NetConnection -ComputerName <IP_WSL> -Port 11434
```

**Passo 4 (Opcional): Instalar Ollama Desktop para Windows**

1. Baixe o instalador em ollama.com
2. Execute o instalador
3. Use junto com WSL se quiser interface gráfica

#### Testar API (todos os sitemas)

```bash
# Verificar endpoint da API
curl http://localhost:11434/api/tags

# Ou usando ollama diretamente
ollama list

# Baixar um modelo (exemplo para seu caso)
ollama pull deepseek-coder:1.3b
# ollama pull qwen2.5-coder:0.5b
# ollama pull codegemma:2b

# Executar um modelo
ollama run deepseek-coder:1.3b

# Ver informações do sistema
ollama ps
``` 