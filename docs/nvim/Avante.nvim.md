## About Avante.nvim

[avante.nvim](https://github.com/yetone/avante.nvim) is a Neovim plugin designed to emulate the behaviour of the Cursor AI IDE. It provides users with AI-driven code suggestions and the ability to apply these recommendations directly to their source files with minimal effort.

With this the #28 become outdated

## Key Bindings

The following key bindings are available for use with `avante.nvim`:

| Key Binding                               | Description                                  |
| ----------------------------------------- | -------------------------------------------- |
| <kbd>Leader</kbd><kbd>a</kbd><kbd>a</kbd> | show sidebar                                 |
| <kbd>Leader</kbd><kbd>a</kbd><kbd>r</kbd> | refresh sidebar                              |
| <kbd>Leader</kbd><kbd>a</kbd><kbd>f</kbd> | switch sidebar focus                         |
| <kbd>Leader</kbd><kbd>a</kbd><kbd>e</kbd> | edit selected blocks                         |
| <kbd>c</kbd><kbd>o</kbd>                  | choose ours                                  |
| <kbd>c</kbd><kbd>t</kbd>                  | choose theirs                                |
| <kbd>c</kbd><kbd>a</kbd>                  | choose all theirs                            |
| <kbd>c</kbd><kbd>0</kbd>                  | choose none                                  |
| <kbd>c</kbd><kbd>b</kbd>                  | choose both                                  |
| <kbd>c</kbd><kbd>c</kbd>                  | choose cursor                                |
| <kbd>]</kbd><kbd>x</kbd>                  | move to previous conflict                    |
| <kbd>[</kbd><kbd>x</kbd>                  | move to next conflict                        |
| <kbd>[</kbd><kbd>[</kbd>                  | jump to previous codeblocks (results window) |
| <kbd>]</kbd><kbd>]</kbd>                  | jump to next codeblocks (results windows)    |

> [!NOTE]
>
> If you are using `lazy.nvim`, then all keymap here will be safely set, meaning if `<leader>aa` is already binded, then avante.nvim won't bind this mapping.
> In this case, user will be responsible for setting up their own. See [notes on keymaps](https://github.com/yetone/avante.nvim/wiki#keymaps-and-api-i-guess) for more details.

## Commands

| Command                            | Description                                                                                                 | Examples                                            |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| `:AvanteAsk [question] [position]` | Ask AI about your code. Optional `position` set window position and `ask` enable/disable direct asking mode | `:AvanteAsk position=right Refactor this code here` |
| `:AvanteBuild`                     | Build dependencies for the project                                                                          |
| `:AvanteChat`                      | Start a chat session with AI about your codebase. Default is `ask`=false                                    |
| `:AvanteEdit`                      | Edit the selected code blocks                                                                               |
| `:AvanteFocus`                     | Switch focus to/from the sidebar                                                                            |
| `:AvanteRefresh`                   | Refresh all Avante windows                                                                                  |
| `:AvanteSwitchProvider`            | Switch AI provider (e.g. openai)                                                                            |
| `:AvanteShowRepoMap`               | Show repo map for project's structure                                                                       |
| `:AvanteToggle`                    | Toggle the Avante sidebar                                                                                   |

## Highlight Groups

| Highlight Group             | Description                                   | Notes                                        |
| --------------------------- | --------------------------------------------- | -------------------------------------------- |
| AvanteTitle                 | Title                                         |                                              |
| AvanteReversedTitle         | Used for rounded border                       |                                              |
| AvanteSubtitle              | Selected code title                           |                                              |
| AvanteReversedSubtitle      | Used for rounded border                       |                                              |
| AvanteThirdTitle            | Prompt title                                  |                                              |
| AvanteReversedThirdTitle    | Used for rounded border                       |                                              |
| AvanteConflictCurrent       | Current conflict highlight                    | Default to `Config.highlights.diff.current`  |
| AvanteConflictIncoming      | Incoming conflict highlight                   | Default to `Config.highlights.diff.incoming` |
| AvanteConflictCurrentLabel  | Current conflict label highlight              | Default to shade of `AvanteConflictCurrent`  |
| AvanteConflictIncomingLabel | Incoming conflict label highlight             | Default to shade of `AvanteConflictIncoming` |
| AvantePopupHint             | Usage hints in popup menus                    |                                              |
| AvanteInlineHint            | The end-of-line hint displayed in visual mode |                                              |

See [highlights.lua](./lua/avante/highlights.lua) for more information

