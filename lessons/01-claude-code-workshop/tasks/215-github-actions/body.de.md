## Überblick

Holt Claude aus eurem Terminal in den Workflow eures Teams. Ein GitHub-Actions-Workflow startet
Claude Code auf einem Runner, sobald jemand ein Issue mit einem Label versieht, und Claude
antwortet im Issue: Wie schwierig ist es, welche Dateien sind betroffen, was ist die
wahrscheinliche Ursache, welche Risiken gibt es. Ihr richtet das auf eurem eigenen Fork ein,
probiert es mit einem echten Ticket aus und schränkt dann ein, was Claude in der CI tun darf.

## Das Feature

Die [Claude Code GitHub Action](https://github.com/anthropics/claude-code-action)
(`anthropics/claude-code-action@v1`) führt Claude Code in einem Workflow-Job aus. Sie braucht drei
Dinge:

- **Die Claude GitHub App**, installiert im Repository (<https://github.com/apps/claude>), damit
  Claude kommentieren und Branches pushen kann. Sie öffnet standardmäßig **keine** Pull Requests:
  Wenn Claude Code ändert, pusht es einen Branch und setzt in seinen Kommentar einen Link auf eine
  vorausgefüllte Pull-Request-Seite. Den PR öffnet ihr selbst.
- **Ein Secret** mit euren Zugangsdaten, das an den passenden Input übergeben wird:
  - `CLAUDE_CODE_OAUTH_TOKEN` → `claude_code_oauth_token`: ein langlebiges Token für euer
    Claude-Abo, erstellt mit `claude setup-token`
  - oder `ANTHROPIC_API_KEY` → `anthropic_api_key`: ein API-Key aus der Claude Console
- **Einen Workflow**, der festlegt, wann Claude läuft und was es darf. Die wichtigsten Inputs:

  ```yaml
  - uses: anthropics/claude-code-action@v1
    with:
      claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
      track_progress: true        # Fortschrittskommentar im Issue, während Claude arbeitet
      prompt: |                   # was Claude in diesem Lauf tun soll
        Read the issue and reply with feasibility, affected files, likely cause, and risks.
      claude_args: |              # beliebige Claude-Code-CLI-Flags
        --max-turns 30
        --allowedTools Read,Grep,Glob,Bash(git log:*)
  ```

  Ohne `prompt` beantwortet die Action stattdessen `@claude`-Erwähnungen in Issue- und
  PR-Kommentaren (mit den passenden `on:`-Triggern im Workflow).

`/install-github-app` in Claude Code erledigt die App, das Secret und einen Starter-Workflow in
einem geführten Ablauf. In dieser Aufgabe richtet ihr die Teile von Hand ein, weil das Repository
schon einen Workflow hat.

**Kosten.** Jeder Lauf verbraucht euren Claude-Plan (OAuth-Token) oder wird eurem API-Key
berechnet. GitHub-Actions-Minuten auf Standard-Runnern von GitHub sind für öffentliche Repositories
kostenlos, und euer Fork eines öffentlichen Repositories ist öffentlich. Mit `--max-turns` und
`timeout-minutes` begrenzt ihr einen Lauf.

## Anwendung auf BookMonkey Legacy

> **Repo / Ports:** euer GitHub-Fork von `bookmonkey-legacy`; Claude läuft auf einem
> GitHub-Actions-Runner, lokale Ports sind also nicht nötig
>
> **Login:** kein App-Login; `gh auth login` und ein Claude-Token oder API-Key

[`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy) enthält bereits
`.github/workflows/claude-issue.yml`: Versieht ihr ein Issue mit dem Label `analyse`, kommentiert
Claude; mit dem Label `implement` pusht Claude zusätzlich einen Branch und verlinkt die
vorausgefüllte Pull-Request-Seite. Es braucht nur einen Fork mit Actions, Issues, der App und einem
Secret. Euer Test-Ticket kann das aus der Debugging-Aufgabe sein, in euren eigenen Worten.

Ihr könnt in diesem Training weder ein persönliches Token noch einen API-Key verwenden? Dann macht die
Schritte 1 und 9 lokal (den Workflow lesen, ihn dann mit Claude auf einem Branch einschränken) und
folgt für die Läufe auf GitHub der Live-Demo des Trainers.

## Voraussetzungen

- Ein GitHub-Account und die GitHub CLI, angemeldet (`gh auth login`)
- **Unter Windows:** Die Befehle unten sind Bash. Führt sie in Git Bash aus (kommt mit Git for
  Windows) oder passt sie für PowerShell an: `$FORK = "<your-github-user>/bookmonkey-legacy"`
  statt `FORK=...`; die `gh`- und `git`-Befehle selbst sind gleich
- Euer `bookmonkey-legacy`-Clone und ein Claude-Plan oder API-Key, den ihr dafür nutzen dürft

## Schritte

1. **Lest zuerst den Workflow.** Bittet Claude in eurem Clone, `.github/workflows/claude-issue.yml`
   zu erklären: wann er läuft, welche Berechtigungen er hat, was Claude in jedem Modus tun darf und
   was schiefgehen könnte. Ihr seid dabei, ihm eure Zugangsdaten zu geben. Vergleicht den Prompt mit
   den Berechtigungen und der Tool-Liste: Erlaubt der Workflow mehr, als der Prompt verlangt?
   Schreibt auf, was ihr findet.
2. **Forkt und fügt den Remote hinzu** (im Clone):

   ```bash
   gh repo fork --remote --remote-name fork
   FORK=<your-github-user>/bookmonkey-legacy
   ```

3. **Schaltet ein, was Forks ausgeschaltet lassen.** In eurem Fork auf github.com: Tab **Actions**
   → Workflows aktivieren (Forks starten mit deaktivierten Workflows) und **Settings → General →
   Features** → **Issues** anhaken.
4. **Installiert die Claude GitHub App** nur auf eurem Fork: <https://github.com/apps/claude> →
   Configure → „Only select repositories“.
5. **Fügt das Secret hinzu.** Mit einem Claude-Abo:

   ```bash
   claude setup-token                                  # gibt ein langlebiges Token aus
   gh secret set CLAUDE_CODE_OAUTH_TOKEN --repo $FORK  # einfügen, wenn danach gefragt wird
   ```

   Stattdessen mit einem API-Key: `gh secret set ANTHROPIC_API_KEY --repo $FORK`.
6. **Legt die Labels an**, falls euer Fork noch keine hat:
   `gh label create analyse --repo $FORK` und `gh label create implement --repo $FORK`.
7. **Öffnet ein Issue** in euren eigenen Worten, zum Beispiel das Ticket „Link zum nächsten Band“
   aus der Debugging-Aufgabe, und versieht es mit einem Label:

   ```bash
   gh issue create --repo $FORK --title "Next volume link leads nowhere" --body "..."
   gh issue edit <number> --repo $FORK --add-label analyse
   ```

8. **Zuschauen und lesen.** Verfolgt den Lauf im Tab **Actions** (oder mit
   `gh run watch --repo $FORK`) und lest dann Claudes Kommentar im Issue. Prüft eine Aussage daraus
   am Code: Stimmt die Datei, stimmt der Zeilenbereich?
9. **Ändert den Workflow mit Claude.** Erstellt in eurem Clone einen neuen Branch vom Upstream-Code
   (`git switch -c ci/tighten origin/main`, damit keine eurer eigenen Commits mitkommen) und bittet
   Claude, den Workflow einzuschränken, zum Beispiel: kein `Bash(npm install:*)` für das Label
   `analyse`, ein kleineres `--max-turns`, ein kürzeres `timeout-minutes` oder ein Prompt, der ein
   festes Ausgabeformat verlangt. Prüft den Diff, pusht den Branch nach `fork`
   (`git push -u fork <branch>`; wenn der Push abgelehnt wird, weil er einen Workflow ändert, führt
   einmal `gh auth refresh -s workflow` aus), öffnet in eurem Fork einen PR
   (`gh pr create --repo $FORK --base main --head <branch>`) und mergt ihn. Workflows für
   Issue-Events laufen vom Default-Branch.
10. Wenn der erste Lauf rechtzeitig zurückkam: Entfernt das Label, fügt `analyse` erneut hinzu und
    vergleicht den neuen Kommentar mit dem ersten.
11. **Räumt auf**, wenn ihr fertig seid, damit keine Zugangsdaten zurückbleiben:

    ```bash
    gh secret delete CLAUDE_CODE_OAUTH_TOKEN --repo $FORK   # oder ANTHROPIC_API_KEY
    ```

    Entfernt die Claude-App vom Fork: github.com → euer **Settings → Applications → Installed
    GitHub Apps → Claude → Configure**, dann den Fork aus den ausgewählten Repositories entfernen
    (oder die App deinstallieren). Wenn ihr den Fork nicht mehr braucht, löscht ihn:
    einmal `gh auth refresh -s delete_repo`, dann `gh repo delete $FORK`. Das Token aus
    `claude setup-token` ist ein Jahr gültig: Lasst keine Kopie davon herumliegen.

## Erfolgskriterien

**Feature**

- [ ] Euer Fork hat Actions und Issues aktiviert, die Claude GitHub App installiert und ein Secret gesetzt
- [ ] Das Label `analyse` an einem Issue hat einen Lauf gestartet, und Claude hat das Issue kommentiert
- [ ] Ihr habt mindestens eine Aussage aus Claudes Kommentar am Code geprüft
- [ ] Ihr habt mindestens eine Stelle gefunden, an der der Workflow mehr erlaubt, als der Prompt verlangt
- [ ] Eine mit Claude gemachte Workflow-Änderung ist in eurem Fork gemergt, und der nächste Lauf zeigt ihre Wirkung
- [ ] Ihr könnt sagen, wo die Kosten eines Laufs landen und wie ihr sie begrenzt habt

**Repository funktioniert weiterhin**

- [ ] Der Default-Branch eures Forks besteht weiterhin `npm test`; es wurde nichts gemergt, was ihr nicht geprüft habt
- [ ] Nach dem Aufräumen zeigt `gh secret list --repo $FORK` kein Claude-Secret, und die Claude-App
      hat keinen Zugriff mehr auf den Fork (oder der Fork ist gelöscht)

## Referenzen

- Claude Code: GitHub Actions: https://code.claude.com/docs/en/github-actions
- Claude Code GitHub Action: usage and inputs: https://github.com/anthropics/claude-code-action/blob/main/docs/usage.md
- Claude Code: CLI reference (`--allowedTools`, `--max-turns`): https://code.claude.com/docs/en/cli-reference
- Claude Code: Authentication (long-lived token): https://code.claude.com/docs/en/authentication
- GitHub: Billing for GitHub Actions: https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-actions/about-billing-for-github-actions
- GitHub: Using secrets in GitHub Actions: https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
