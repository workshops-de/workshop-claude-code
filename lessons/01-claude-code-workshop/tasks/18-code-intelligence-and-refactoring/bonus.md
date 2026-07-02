## Going further — code intelligence (Language Server Protocol)

Large or unfamiliar refactors are where **code intelligence** earns its keep. A code-intelligence
plugin connects Claude to a **language server** so it can jump to a symbol's definition, find all
references, and surface type errors directly — instead of reading and grepping through files.

Try installing the language-server plugin for your stack (for example
`/plugin install typescript-lsp@claude-plugins-official`), then ask Claude to find every caller of
a function and rename it — compare the experience to a grep-and-read refactor.
