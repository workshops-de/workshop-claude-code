In dieser Aufgabe geht es um die **GitHub Action für Claude Code**: Ein Workflow startet Claude auf einem GitHub-Server, sobald jemand ein Issue mit einem Label versieht, und Claude antwortet im Issue. Den Lauf auf GitHub zeigt der Trainer live. Ihr baut ihn lokal nach, seht, was Claude dort darf, und schränkt es ein.

Ihr arbeitet in eurem `bookmonkey-legacy`-Clone mit Node.js 24, es muss kein Server laufen. Die Befehle mit `claude -p` tippt ihr im Terminal der Desktop-App ein (unter Windows in der Git Bash).

### 1. Lasst Claude den Workflow erklären

Startet eine neue Session und schickt:

```text
Erkläre .github/workflows/claude-issue.yml: Wann läuft der Workflow, welche Rechte hat er, was darf Claude pro Label tun? Wo erlaubt der Workflow mehr, als der Prompt verlangt?
```

Wer den Workflow auf GitHub einsetzt, gibt ihm Zugangsdaten, darum lohnt sich der Blick. In unserem Lauf nannte Claude mehrere Stellen. Lest sie und merkt euch eine.

### 2. Spielt den Lauf lokal nach

Die Action ruft Claude mit einem Prompt und einer Liste erlaubter Tools auf. Das könnt ihr nachstellen. Der Prompt und die Tool-Liste entsprechen ungefähr dem, was der Workflow aus einem Issue macht:

```text
claude -p 'Issue #1: "Merkliste als CSV herunterladen". Lies die Codebasis. Antworte mit: 1. Machbarkeit (leicht, mittel, schwer) und warum. 2. Betroffene Dateien mit Zeilenbereichen. 3. Wahrscheinliche Ursache, falls das Issue einen Fehler beschreibt, nutze die Git-Historie, wo sie hilft. 4. Risiken und was zu testen ist. Ändere keine Dateien.' --max-turns 30 --allowedTools "Read,Grep,Glob,Bash(git log:*),Bash(git show:*),Bash(git blame:*),Bash(npm test:*)"
```

In unserem Lauf dauerte das knapp eine Minute, und es wurde nichts geändert. Prüft eine Aussage der Antwort am Code: Stimmt die Datei, stimmt der Zeilenbereich?

### 3. Testet die Grenze

Auf dem Server fragt niemand nach, was Claude tun darf. Was eine Freigabe bräuchte und nicht in der Liste steht, wird abgelehnt:

```text
claude -p 'Lege eine Datei hallo.txt mit dem Inhalt "Hallo" an. Dann lies git log -1.' --max-turns 15 --allowedTools "Read,Grep,Glob,Bash(git log:*)"
```

In unserem Lauf wurde `hallo.txt` nicht angelegt, `git log -1` lief.

### 4. Schränkt den Workflow ein

Sagt Claude in eigenen Worten, was der Workflow weniger bekommen soll. Ziel: ein Lauf, der nur das darf und kostet, was er braucht. Nehmt eine Stelle aus Schritt 1.

Zum Beispiel:

```text
Der Workflow gibt einem analyse-Lauf mehr, als er braucht. Entferne das Tool, das du gerade als unnötig genannt hast, und halbiere --max-turns und timeout-minutes. Ändere sonst nichts, zeig mir danach den Diff.
```

Lest den Diff. In unserem Lauf wies Claude darauf hin, dass die Änderung auch für das Label `implement` gilt, weil beide Labels denselben Job nutzen. Ob die Änderung auf GitHub wirkt, zeigt nur ein echter Lauf. Hier prüft ihr den Diff.

### 5. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

Die Action ist ein `claude -p`-Aufruf auf einem GitHub-Server: Der Prompt kommt aus dem Issue, `--allowedTools` legt fest, was ohne Rückfrage läuft, `--max-turns` und `timeout-minutes` begrenzen Dauer und Kosten. Titel und Text des Issues landen im Prompt, deshalb gehört in die Liste nur, was der Modus braucht. Was Claude im Issue schreibt, prüft ihr wie ein Review.

**Fertig, wenn** ihr den Lauf lokal nachgespielt habt, eine Aussage von Claude am Code geprüft habt und eure Workflow-Änderung committet ist.

<details>
<summary>Mehr dazu</summary>

- Auf GitHub braucht der Workflow laut Docs die Claude GitHub App im Repository und ein Secret (`CLAUDE_CODE_OAUTH_TOKEN` aus `claude setup-token` oder `ANTHROPIC_API_KEY`). `/install-github-app` richtet das geführt ein. Jeder Lauf verbraucht euren Claude-Plan oder wird eurem API-Key berechnet. Wer es selbst ausprobieren will, forkt das Repository, schaltet im Fork Actions und Issues ein und legt die Labels `analyse` und `implement` an. Räumt danach Secret und App-Zugriff wieder auf.
- [GitHub Actions](https://code.claude.com/docs/en/github-actions) · [Action-Inputs](https://github.com/anthropics/claude-code-action/blob/main/docs/usage.md) · [Authentifizierung](https://code.claude.com/docs/en/authentication)

</details>
