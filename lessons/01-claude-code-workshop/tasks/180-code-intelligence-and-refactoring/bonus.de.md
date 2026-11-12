## Bonus: Das Refactoring in der Sandbox

Im Modus Auto führt Claude Befehle ohne Nachfrage aus. Eine Sandbox begrenzt, worauf diese Befehle zugreifen dürfen (Aufgabe 030, Schritt 7). Hier seht ihr, was sie bei einem echten Projekt blockiert und wie ihr genau das eine freigebt. Macht den Bonus vor Schritt 8, solange der Stop-Hook noch eingetragen ist.

1. **Sandbox nur für dieses Repo einschalten.** Das geht in der Desktop-App und im Terminal gleich, über die Datei aus Schritt 5. Wir haben beides getestet: Beide lesen die Sandbox-Einträge aus dieser Datei, auch `allowLocalBinding` aus Punkt 4. Schreibt:

   ```text
   Füge in .claude/settings.local.json diesen Eintrag ein und lass vorhandene Einträge stehen: "sandbox": { "enabled": true, "allowUnsandboxedCommands": false }
   ```

   In der Desktop-App gibt es auch den Schalter **Settings → Local sandbox**. Er gilt aber für alle neuen Sessions in allen Projekten, und die Netzwerk-Einstellung aus Punkt 4 hat er nicht. Deshalb nehmt ihr hier die Datei.

2. **Testet in der Sandbox.** Sagt vorher, was passiert. Startet dann eine neue Session und schreibt:

   ```text
   Führe genau einmal npm test aus und nenne mir die Zeilen mit tests, pass und fail sowie jede Zeile mit EPERM. Ändere nichts.
   ```

   In unserem Lauf scheiterten die Tests an `listen EPERM: operation not permitted`: Sie starten einen Server, und die Sandbox verbietet, einen Port zu öffnen.

3. **Schaut auf den Hook.** Claudes `npm test` ist gerade an `EPERM` gescheitert. Hat der Stop-Hook Claude trotzdem aufhören lassen? Hooks laufen außerhalb der Sandbox: In unserem Lauf war das `npm test` des Hooks grün, und Claude durfte aufhören. Was bedeutet das für einen Hook, dem ihr Sicherheit anvertraut?

4. **Gebt genau das frei.** Ergänzt im Sandbox-Eintrag `"network": { "allowLocalBinding": true }`, startet eine neue Session und schickt denselben Prompt. In unseren Läufen unter macOS, in der Desktop-App und im Terminal, waren danach alle Tests grün, wie ohne Sandbox. `allowLocalBinding` wirkt laut Doku nur unter macOS. Unter Linux und WSL2 nehmt ihr stattdessen `excludedCommands` (siehe [Sandboxing](https://code.claude.com/docs/en/sandboxing)).

5. **Räumt auf:** Entfernt den Sandbox-Eintrag wieder aus `.claude/settings.local.json`, sonst gilt er auch in den späteren Aufgaben. Habt ihr den Schalter **Local sandbox** eingeschaltet, schaltet ihn wieder aus: Er gilt für alle neuen Sessions, und Tests, die einen Server starten, scheitern dort an `EPERM`.

Natives Windows hat keine Sandbox, WSL2 schon.

## Weiterführend: Code Intelligence (Language Server Protocol)

Bei großen oder unbekannten Refactorings zahlt sich **Code Intelligence** aus. Ein
Code-Intelligence-Plugin verbindet Claude mit einem **Language Server**, sodass es zur Definition
eines Symbols springen, alle Referenzen finden und Typfehler direkt anzeigen kann, statt Dateien zu
lesen und zu durchsuchen.

Installiert das Language-Server-Plugin für euren Stack (zum Beispiel
`/plugin install typescript-lsp@claude-plugins-official`), lasst Claude dann alle Aufrufer einer
Funktion finden und sie umbenennen, und vergleicht das Erlebnis mit einem Refactoring per grep und
Lesen.
