# VSCODE CONFIGS


## Using XDG

No Linux, o Visual Studio Code segue o padrão XDG Base Directory para armazenar as configurações do usuário e dados da aplicação. 
Os caminhos padrão são: 

**1. Configurações de Usuário (XDG_CONFIG_HOME)**

Os arquivos de configuração (como o `settings.json` e `keybindings.json`) ficam no diretório definido pela variável `$XDG_CONFIG_HOME`. Se esta variável não estiver definida, o padrão é `$HOME/.config`. 

- Caminho: `$HOME/.config/Code/User/`.
- Versão OSS: Se você usa o VS Code Open Source (code-oss), o caminho costuma ser `$HOME/.config/Code - OSS/User/` ou `~/.config/vscode-oss/`. 

**2. Cache (XDG_CACHE_HOME)** 

- Arquivos temporários e cache de ferramentas (como o C++) são armazenados no diretório de cache. 
- Caminho: $HOME/.cache/Code/ ou $XDG_CACHE_HOME/vscode-cpptools/. 

**3. Dados e Extensões (XDG_DATA_HOME)**

Embora o VS Code tradicionalmente use `~/.vscode/extensions` para extensões, versões baseadas em servidor ou implementações estritas do padrão XDG podem mover dados para o diretório de dados. 
- Caminho: $HOME/.local/share/Code/. 

**Resumo dos principais arquivos no padrão XDG:**

| Tipo de Arquivo | Localização Padrão (Linux) |
|-----------------|----------------------------|
| Configurações (JSON) |	~/.config/Code/User/settings.json |
| Atalhos de Teclado |	~/.config/Code/User/keybindings.json |
| Snippets de Usuário |	~/.config/Code/User/snippets/ |
| Configurações MCP	| ~/.vscode/mcp.json (dentro do workspace) |