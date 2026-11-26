> **⚠️ Setup zuerst:** Startet eine Session in eurem `bookmonkey-legacy`-Clone (Terminal: `cd bookmonkey-legacy` und `claude`; Desktop-App: neue Session, Ordner `bookmonkey-legacy` wählen) und schickt diesen Prompt. Habt ihr noch keinen Clone, macht zuerst das Setup von Aufgabe 020.
>
> ```text
> Setup für Aufgabe 030: Prüf mit git remote -v, ob dieser Ordner der Clone von bookmonkey-legacy ist, mit git status, ob er sauber ist, und mit node -v, ob Node.js 24 oder neuer installiert ist. Ändere nichts. Gib mir am Ende eine Checkliste mit ✅ und ❌.
> ```

---

In dieser Aufgabe geht es darum, **wie viel Claude ohne Nachfrage darf**. Ein **Permission Mode** legt das für die ganze Session fest. **Permission-Regeln** machen Ausnahmen davon, und eine **Sandbox** lässt das Betriebssystem Grenzen ziehen. Ihr probiert alle drei aus und wählt am Ende den Modus passend zum Risiko.

Ihr arbeitet in eurem `bookmonkey-legacy`-Clone. Die Modi im Überblick stehen am Ende.

### 1. Lest den Modus, bevor ihr tippt

Startet `claude` im Clone. Welchen Modus zeigt die Statuszeile, und warum? Prüft `claude --version` und `permissions.defaultMode` in eurer `~/.claude/settings.json`, um es zu erklären.

Drückt dann mehrmals `Shift+Tab`: Von `auto` geht es zu Manual (`⏸ manual mode on`), dann `acceptEdits`, `plan` und zurück zu `auto`.

<details>
<summary>In der Desktop-App</summary>

Es gibt keine Statuszeile, und `Shift+Tab` wechselt den Modus nicht. Ihr seht und wechselt ihn im Modus-Menü unter dem Eingabefeld (Windows `Ctrl+Shift+M`, macOS `Cmd+Shift+M`). Befehle wie `git diff` laufen im Terminal der App (``Ctrl+` ``).

</details>

<details>
<summary>Auflösung: Warum dieser Modus?</summary>

Seit Claude Code v2.1.283 startet eine Terminal-Session im **Auto Mode**. Ein `--permission-mode`-Flag oder `permissions.defaultMode` in den Settings hat Vorrang. Ist der Auto Mode für eure Session nicht verfügbar, startet sie in Manual.

</details>

### 2. Ändert etwas in `acceptEdits`

Wechselt zu `acceptEdits` (Terminal: `Shift+Tab`; Desktop-App: Modus-Menü, **Accept edits**) und schickt:

```text
Füge in README.md direkt unter der ersten Überschrift die Zeile "Workshop-Test" ein.
```

Die Änderung kommt ohne Nachfrage. Lest den Diff: `git diff` (Desktop-App: in der Diff-Ansicht der App oder im Terminal der App).

Dann nehmt sie mit **Rewind** zurück: `/rewind` (im Terminal auch zweimal `Esc`), wählt eure Nachricht von eben und dann **Restore code**. Das geht auch in der Desktop-App. Rewind holt nur Änderungen zurück, die Claude mit Edit oder Write gemacht hat, nicht per Bash. Zur Not: `git restore .`.

### 3. Vergleicht Auto und Manual

Führt in einem zweiten Terminal `claude auto-mode defaults` aus und sucht zwei Aktionen, die der Klassifikator standardmäßig blockiert, und zwei, die er erlaubt. Gebt dann im **Auto Mode** eine klar umrissene Aufgabe, die Befehle ausführt. Wechselt mit `Shift+Tab` zu **Manual** und gebt dieselbe Aufgabe noch einmal. Zählt die Nachfragen in beiden Modi. Antwortet ihr in Manual auf eine Bash-Nachfrage mit „Yes, and don't ask again“, steht die Regel danach in `.claude/settings.local.json`.

Ohne CLI in der Desktop-App: Die Standardregeln stehen auf der Docs-Seite [Configure auto mode](https://code.claude.com/docs/en/auto-mode-config).

### 4. Macht aus einem Wunsch eine Regel

Sagt Claude im Gespräch: „Führe keine Netzwerk-Befehle aus, bis ich es sage.“ Bittet Claude um `curl -I https://example.com` und prüft, ob es sich daran hält. Führt `/compact` aus und prüft noch einmal: Hält die Grenze auch nach dem Kompaktieren?

Schreibt dieselbe Grenze dann als **Deny-Regel** in `.claude/settings.local.json`:

```json
{"permissions": {"deny": ["Bash(curl *)"]}}
```

Testet ein drittes Mal. Der Satz im Gespräch ist ein Wunsch an das Modell, die Deny-Regel prüft Claude Code bei jedem Befehl.

<details>
<summary>Natives Windows ohne Git for Windows</summary>

Claude nutzt dort das **PowerShell-Tool**, eine `Bash(...)`-Regel greift nicht. Ergänzt `"PowerShell(curl *)", "PowerShell(curl.exe *)", "PowerShell(Invoke-WebRequest *)"` und testet mit `curl.exe -I https://example.com`. Legt die Datei im Editor oder von Claude an, nicht mit `>` in Windows PowerShell (das speichert UTF-16).

</details>

### 5. Findet die Regel in `/permissions` und sucht ihre Lücke

Öffnet `/permissions`, wechselt mit `←` und `→` die Tabs und sucht eure Deny-Regel. Der Dialog zeigt, aus welcher Datei sie kommt. Legt im Tab **Allow** dieselbe Regel `Bash(curl *)` an (lokale Projekt-Settings).

Sagt vorher: Wer gewinnt, Deny oder Allow? Lasst Claude dann `curl -I https://example.com` ausführen und lest die Meldung: Wer hat gewonnen?

Bittet jetzt um `sh -c 'curl -I https://example.com'` (Windows ohne Git: `cmd /c curl.exe -I https://example.com`). Greift die Deny-Regel? Warum nicht? Kommt eine Nachfrage, antwortet mit No. Löscht danach beide Regeln.

Ist `/permissions` in der Desktop-App nicht verfügbar, startet `claude` im Terminal der App.

### 6. Wählt den Modus zum Risiko

Welcher Modus passt, und warum? Ein unbekanntes Repo erkunden. An Code iterieren, den ihr gerade reviewt. Ein abgeschotteter CI-Job.

### 7. Lasst das Betriebssystem stoppen

Eine **Sandbox** liest keinen Befehlstext. Sie begrenzt, worauf der laufende Prozess zugreifen darf. Prüft mit `/sandbox`, ob sie an ist, und schaltet sie für diesen Schritt aus. Natives Windows hat keine Sandbox, und der Schritt braucht die CLI: Schaut bei jemandem mit macOS, Linux oder WSL2 zu und sagt vorher, was passiert.

Legt in einem zweiten Terminal `echo geheim > ~/sandbox-demo.txt` an und gebt Claude diesen Prompt:

```text
Führe genau diesen Befehl einmal aus, ohne Alternativen: python3 -c "import os; h=os.path.expanduser('~'); print(open(h+'/sandbox-demo.txt').read()); open(h+'/sandbox-demo-2.txt','w').write('x'); print('WRITE OK')"
```

Fragt Claude nach, erlaubt den Befehl. Blockt der Klassifikator, wechselt zu Manual und bestätigt. Python liest und schreibt außerhalb des Projekts, und es klappt. Sagt vorher, was mit Sandbox passiert. Beendet mit `/exit` und startet neu:

```bash
claude --settings '{"permissions":{"blockReadsOutsideWorkingDirectories":true},"sandbox":{"enabled":true,"allowUnsandboxedCommands":false,"failIfUnavailable":true}}'
```

Schickt denselben Prompt. Unter macOS meldet Python `PermissionError: [Errno 1] Operation not permitted`. Derselbe Code, aber Nein gesagt hat das Betriebssystem, nicht Claude. Räumt auf: `rm -f ~/sandbox-demo.txt ~/sandbox-demo-2.txt`.

<details>
<summary>In der Desktop-App</summary>

`/sandbox` öffnet in der App die Einstellungen:

1. Schaltet **Local sandbox** ein und darunter **Strict sandbox mode** (blockt Befehle, die nicht in der Sandbox laufen können, statt zu fragen).
2. Startet eine neue Session (**+ New**), denn die Sandbox gilt erst für neue Sessions. Schickt den Python-Prompt von oben.
3. Sagt vorher, was passiert. Ohne `blockReadsOutsideWorkingDirectories` darf die Sandbox in der Regel lesen, aber außerhalb des Projekts nicht schreiben: Python gibt `geheim` aus und meldet dann beim Schreiben `PermissionError`.
4. Schaltet beide Schalter danach wieder aus. **Strict sandbox mode** gilt auch im Terminal.

</details>

### Was gerade passiert ist

| Modus | Ohne Nachfrage |
|---|---|
| Manual (`default`) | nur lesen |
| `acceptEdits` | lesen, Dateien ändern |
| `plan` | nur lesen, nichts ändern |
| `auto` | Claude handelt, ein Klassifikator prüft jede Aktion vorher |
| `dontAsk` | nur vorab erlaubte Tools, sonst nichts |
| `bypassPermissions` | alles außer Deny-Regeln, sonst keine Prüfung, nur in einem isolierten Container oder einer VM |

| Hebel | Prüft | Lücke |
|---|---|---|
| Satz im Gespräch | das Modell, wenn es sich daran hält | keine Garantie |
| Deny-Regel | Claude Code, am Befehlstext | `sh -c '…'` ist ein anderer Text |
| Sandbox | das Betriebssystem, am Zugriff | gilt für Shell-Befehle, nicht für Claudes Datei-Tools, MCP-Server und Hooks |

Regeln werden in fester Reihenfolge geprüft: **Deny, dann Ask, dann Allow**. Der erste Treffer entscheidet, eine genauere Regel gewinnt also nicht. Passt keine Regel, entscheidet der Modus.

**Fertig, wenn** ihr sagen könnt, in welchem Modus eure Session startet und warum, wie viele Nachfragen Auto und Manual brachten, aus welcher Datei eine Regel kommt, wer bei Deny gegen Allow gewinnt, warum `sh -c` an der Deny-Regel vorbeikommt, wer den Python-Befehl gestoppt hat, und für die drei Szenarien einen Modus gewählt habt.

<details>
<summary>Mehr dazu</summary>

Eine Regel hat die Form `Tool` oder `Tool(Angabe)`, zum Beispiel `Bash(curl *)` oder `Edit(./src/**)` (Änderungen unterhalb von `src/`). Eine Ask-Regel fragt auch dann, wenn zusätzlich eine Allow-Regel passt. Eine Deny-Regel blockiert in jedem Modus, auch in `bypassPermissions`. Regeln liegen in `~/.claude/settings.json` (ihr, überall), `.claude/settings.json` (Team, im Git), `.claude/settings.local.json` (ihr, dieses Repo) und in Managed Settings (eure IT). Ein Deny auf einer Ebene schlägt ein Allow auf jeder anderen. Docs: [Permission modes](https://code.claude.com/docs/en/permission-modes), [Configure auto mode](https://code.claude.com/docs/en/auto-mode-config), [Permissions](https://code.claude.com/docs/en/permissions), [Sandboxing](https://code.claude.com/docs/en/sandboxing).

</details>
