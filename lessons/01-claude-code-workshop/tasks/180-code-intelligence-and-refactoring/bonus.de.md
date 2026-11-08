## Weiterführend: Code Intelligence (Language Server Protocol)

Bei großen oder unbekannten Refactorings zahlt sich **Code Intelligence** aus. Ein
Code-Intelligence-Plugin verbindet Claude mit einem **Language Server**, sodass es zur Definition
eines Symbols springen, alle Referenzen finden und Typfehler direkt anzeigen kann, statt Dateien zu
lesen und zu durchsuchen.

Installiert das Language-Server-Plugin für euren Stack (zum Beispiel
`/plugin install typescript-lsp@claude-plugins-official`), lasst Claude dann alle Aufrufer einer
Funktion finden und sie umbenennen, und vergleicht das Erlebnis mit einem Refactoring per grep und
Lesen.
