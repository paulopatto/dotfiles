# Suporte a Java no Neovim

Este projeto oferece suporte completo ao desenvolvimento em Java através da integração com o **Eclipse JDT Language Server (jdtls)**, proporcionando uma experiência de desenvolvimento moderna com recursos como autocompletar, navegação de código, refatoração e depuração.

## O que é o JDTLS?

O **Eclipse JDT Language Server** é um servidor de linguagem que implementa o protocolo LSP (Language Server Protocol) para Java. Ele foi desenvolvido pela Eclipse Foundation e oferece:

- **IntelliSense avançado**: Autocompletar, verificação de sintaxe e análise de código em tempo real
- **Navegação de código**: Go-to-definition, find references, outline e hierarchy
- **Refatoração**: Rename, extract method, organize imports e muito mais
- **Depuração**: Integração completa com debugger através do DAP (Debug Adapter Protocol)
- **Gerenciamento de projetos**: Suporte a Maven, Gradle e projetos Eclipse
- **Formatação e organização**: Code formatting e import organization

## Integração com Neovim

### nvim-jdtls

O plugin `mfussenegger/nvim-jdtls` é uma extensão especializada do cliente LSP nativo do Neovim, oferecendo funcionalidades específicas do Java:

```lua
-- Exemplo de configuração básica
local config = {
  cmd = {'/path/to/jdtls'},
  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),

  -- Configurações específicas do jdtls
  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      format = { enabled = true },
    }
  },

  -- Inicialização de funcionalidades específicas
  init_options = {
    bundles = {}
  }
}

require('jdtls').start_or_attach(config)
```

**Funcionalidades exclusivas do nvim-jdtls:**

- **Organize imports**: `:lua require'jdtls'.organize_imports()`
- **Extract variable/method**: `:lua require'jdtls'.extract_variable()`
- **Generate constructors/getters/setters**: `:lua require'jdtls'.code_action()`
- **Test integration**: Execução de testes JUnit diretamente no Neovim

### nvim-dap (Depuração)

O `mfussenegger/nvim-dap` trabalha em conjunto com o jdtls para fornecer capacidades de depuração:

```lua
-- Configuração do DAP para Java
local dap = require('dap')

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

-- Integração com jdtls
require('jdtls').setup_dap({ hotcodereplace = 'auto' })
```

**Recursos de depuração:**

- Breakpoints condicionais
- Variáveis watch
- Call stack navigation
- Hot code replacement
- Remote debugging

## Instalação do JDTLS

### Pré-requisitos

O JDTLS requer **Java 17 ou superior**:

```bash
# Verificar versão do Java
java -version

# Se necessário, instalar Java 17+
```

### macOS

**Via Homebrew (recomendado):**

```bash
# Instalar Java se necessário
brew install openjdk@17

# Instalar jdtls
brew install jdtls
```

O executável ficará disponível em `/opt/homebrew/bin/jdtls`.

### Ubuntu

**Via APT (recomendado):**

```bash
# Instalar Java se necessário
sudo apt update
sudo apt install openjdk-17-jdk

# Instalar jdtls
sudo apt install eclipse-jdt-language-server
```

O servidor ficará disponível em `/usr/share/java/jdtls/`.

### Fedora

**Via DNF (recomendado):**

```bash
# Instalar Java se necessário
sudo dnf install java-17-openjdk-devel

# Instalar jdtls
sudo dnf install eclipse-jdt-language-server
```

### Instalação Manual

Para todas as plataformas, você pode baixar e instalar manualmente:

```bash
# 1. Criar diretório de instalação
sudo mkdir -p /opt/jdtls

# 2. Baixar a versão mais recente
JDTLS_VERSION="1.38.0"  # Verificar versão atual no site
curl -LO "http://download.eclipse.org/jdtls/milestones/${JDTLS_VERSION}/jdt-language-server-${JDTLS_VERSION}-202406271335.tar.gz"

# 3. Extrair arquivos
sudo tar -xzf jdt-language-server-*.tar.gz -C /opt/jdtls

# 4. Verificar instalação
ls /opt/jdtls/plugins/org.eclipse.equinox.launcher_*.jar
```

**Script de inicialização** (`/usr/local/bin/jdtls`):

```bash
#!/usr/bin/env bash

JAR="/opt/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED \
  -jar $(echo $JAR) \
  -configuration /opt/jdtls/config_linux \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
```

Torne o script executável:

```bash
sudo chmod +x /usr/local/bin/jdtls
```

## Verificação da Instalação

Para verificar se o jdtls está funcionando corretamente:

```bash
# Testar execução do servidor
jdtls --help

# Ou verificar se o jar está no local correto
java -jar /opt/jdtls/plugins/org.eclipse.equinox.launcher_*.jar --help
```

## Configuração no Projeto

Após a instalação, configure o nvim-jdtls apontando para o executável correto:

```lua
local config = {
  cmd = {
    'jdtls',  -- ou caminho completo: '/opt/homebrew/bin/jdtls'
    -- Adicione configurações específicas do seu ambiente
  },
  -- ... resto da configuração
}
```

## Troubleshooting

**Problemas comuns:**

1. **Java não encontrado**: Verifique se o `JAVA_HOME` está configurado corretamente
2. **Permissões**: Certifique-se de que o script jdtls tem permissões de execução
3. **Workspace**: Configure um diretório de workspace adequado para seus projetos
4. **Memory**: Ajuste os parâmetros `-Xms` e `-Xmx` conforme necessário para projetos grandes

Para mais detalhes sobre configuração avançada, consulte a [documentação oficial do nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls).

