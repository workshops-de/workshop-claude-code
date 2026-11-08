## Überblick

Reviewt den Pull Request eines Kollegen auf professionelle Weise: ein automatisiertes Review auf
Korrektheit, ein separater Security-Durchgang durch einen spezialisierten Subagent und eure eigene
Triage jedes Findings. Das Leitprinzip ist **„You push it, you own it“**, und für Reviewende:
**you approve it, you own it**. Das Agenten-Review unterstützt, es entbindet nicht von der
Verantwortung.

## Das Feature

- **`/code-review`** prüft Änderungen auf Korrektheitsfehler. Ohne Ziel reviewt es euren aktuellen
  Branch; mit Ziel reviewt es stattdessen dieses:

  ```text
  /code-review main...review/admin-export-v2
  /code-review high main...review/admin-export-v2
  ```

  Eine Effort-Stufe (`low` bis `max`) tauscht Treffsicherheit gegen Abdeckung: `low` meldet nur die
  Findings, bei denen es sich am sichersten ist. In einer Terminal-Session läuft das Review als
  Hintergrund-Subagent mit eigenem Kontext, und die Findings kommen in eure Konversation. `--fix`
  wendet sie an, `--comment` postet sie in einen GitHub-PR. `/review` ist ein Alias.
- **`/security-review`** analysiert den Diff zwischen eurem aktuellen Branch und dem Default-Branch
  von `origin` auf Schwachstellen wie Injection, Auth-Probleme und Datenpreisgabe.
- **Ein Security-Subagent** ist euer eigener Reviewer mit fokussiertem Prompt und ohne
  Edit-Tools, in `.claude/agents/`. Ruft ihn beim Namen auf (`@agent-security-reviewer`), damit das
  Review in einem eigenen Kontext läuft und nur die Findings zurückkommen.
- **Die Triage** liegt bei euch. Jedes Finding bekommt ein Urteil: echt (mit Schweregrad), falsch
  positiv (mit Begründung) oder muss diskutiert werden.

## Anwendung auf BookMonkey Legacy

> **Repo / Ports:** euer `bookmonkey-legacy`-Clone (Node.js 24 oder neuer), API auf
> http://localhost:4780, Web-App auf http://localhost:5180
>
> **Login:** Admin `admin@bookmonkey.example` / `admin2021`

Das Übungsfeld ist euer [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)-Clone.
Dana hat einen Pull Request fertig: Der Branch `feature/admin-export-v2` fügt einen Export von
Reviews und Ausleihen als CSV hinzu, mit einer neuen Box auf der Admin-Ausleihseite und Tests. Die
Tests sind grün, die Beschreibung ist kurz, und Dana hat es eilig. Ihr übernehmt das Review.

## Voraussetzungen

- Der `bookmonkey-legacy`-Clone mit durchgeführtem `npm install` und die `CLAUDE.md`, die ihr in
  der CLAUDE.md-Aufgabe auf `main` committet habt

## Schritte

1. **Holt den Branch, mit eurer Memory-Datei.** Committet oder stasht zuerst, was von den Aufgaben
   Refactoring, Debugging und GitHub Actions übrig ist (`git status` muss sauber sein; `git stash`
   ist in Ordnung, wenn ihr unsicher seid). Erstellt dann aus Danas Branch einen lokalen
   Review-Branch und mergt euer `main` hinein, damit eure `CLAUDE.md` mitkommt:

   ```bash
   git fetch origin
   git switch -c review/admin-export-v2 origin/feature/admin-export-v2
   git merge --no-edit main
   npm run db:reset
   ```

   Der Diff `main...review/admin-export-v2` zeigt weiterhin nur Danas Änderungen.

2. **Versteht zuerst die Änderung.** Bittet Claude um eine Zusammenfassung von
   `git log main..review/admin-export-v2` und `git diff --stat main...review/admin-export-v2`:
   was das Feature tut und welche Dateien es berührt. Führt `npm test` aus.
3. **Startet das Korrektheits-Review**: `/code-review main...review/admin-export-v2`. Während es im
   Hintergrund läuft, lest den Diff selbst und notiert, was ihr bemängeln würdet.
4. **Erstellt einen Security-Subagent** im Clone, `.claude/agents/security-reviewer.md`, ohne
   Edit-Tools (oder kopiert den aus der Subagents-Aufgabe):

   ```markdown
   ---
   name: security-reviewer
   description: Reviews a diff for security issues.
   tools: Read, Grep, Glob
   ---
   You are a security reviewer. Review only the files and changes you are given, in the context
   of the code they call. For each finding give severity, file and line, an attack scenario in one sentence,
   and a fix. Do not edit files.
   ```

   Startet Claude Code neu (oder wartet, bis es die Datei übernimmt) und fragt dann
   `@agent-security-reviewer review the changes of main...review/admin-export-v2` (die Haupt-Session
   gibt ihm den Diff mit). Optional vergleicht ihr mit
   `/security-review` auf dem Branch.
5. **Triagiert** alle Findings aus beiden Reviews und eure eigene Liste in einer Tabelle: Finding,
   Quelle, Urteil (echt / falsch positiv / diskutieren), Schweregrad und eure Begründung. Lasst euch
   bei jedem „echt“ von Claude zeigen, wie man es auslöst (ein `curl`, ein Test, eine präparierte
   Eingabe), und prüft eines selbst.
6. **Schreibt das Review**, wie ihr es für Dana posten würdet: blockierende Punkte zuerst, jeweils
   mit einem Korrekturvorschlag; nicht blockierende Anmerkungen danach. Lasst Claude es aus eurer
   Tabelle entwerfen und überarbeitet es dann in euren eigenen Worten.
7. **Behebt ein blockierendes Finding** auf dem Branch mit einem Test, der es belegt, und führt
   `/code-review` erneut auf dem Branch aus, um zu sehen, wie sich die Findings verändern.
8. Reflektiert: Was haben die Agenten gefunden, das ihr übersehen habt, was habt ihr gefunden, das
   sie übersehen haben, und welches Finding war falsch?
9. **Optional: Security-Durchgang über `main`.** Wechselt zu `main` von `bookmonkey-legacy` und
   bittet denselben `security-reviewer`-Subagent, den bestehenden Code zu reviewen, nicht nur einen
   Diff. Triagiert seine Findings genauso: Urteil, Schweregrad, Begründung und eine Reproduktion für
   jedes „echt“.

## Erfolgskriterien

**Feature**

- [ ] `/code-review` lief auf `main...review/admin-export-v2` und ihr habt seine Findings gelesen
- [ ] Ein Security-Subagent ohne Edit-Tools hat denselben Diff in einem eigenen Kontext reviewt
- [ ] Jedes Finding hat ein Urteil und eine Begründung, darunter mindestens ein falsch positives oder „diskutieren“
- [ ] Ihr habt mindestens ein echtes Finding selbst reproduziert, statt dem Bericht zu vertrauen

**Das Review ist nützlich**

- [ ] Ein schriftliches Review liegt vor, mit blockierenden Punkten zuerst und einem Korrekturvorschlag für jeden
- [ ] Ein blockierendes Finding ist auf dem Branch mit einem Test behoben; `npm test` ist grün
- [ ] Ihr könnt sagen, ob ihr den PR jetzt freigeben würdet, und warum

## Referenzen

- Claude Code: Review locally with `/code-review`: https://code.claude.com/docs/en/code-review-local
- Claude Code: Commands (`/security-review`): https://code.claude.com/docs/en/commands
- Claude Code: Subagents: https://code.claude.com/docs/en/sub-agents
- Claude Code: Code Review for GitHub (managed service): https://code.claude.com/docs/en/code-review
- OWASP Top Ten: https://owasp.org/www-project-top-ten/
- GitHub: About pull request reviews: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews
