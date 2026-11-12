> **⚠️ Vorher beenden:** Läuft die API noch aus der Debugging-Aufgabe, beendet sie mit Ctrl+C. In Schritt 1 startet ihr sie neu.

---

In dieser Aufgabe reviewt ihr den Pull Request eines Kollegen mit **/code-review** und einem eigenen **Security-Subagent**, einem Helfer mit eigenem Kontext, der nur lesen darf. Danas Branch `feature/admin-export-v2` fügt einen CSV-Export hinzu, die Tests sind grün, und Dana hat es eilig.

Ihr arbeitet in eurem `bookmonkey-legacy`-Clone (Node.js 24 oder neuer). Ist `git status` nicht sauber, führt zuerst `git stash` aus.

### 1. Holt Danas Branch

```bash
git fetch origin
git switch -c review/admin-export-v2 origin/feature/admin-export-v2
git merge --no-edit main
npm run db:reset
```

Der Merge holt eure `CLAUDE.md` und Einstellungen aus `main` in den Review-Branch. Der Diff `main...review/admin-export-v2` mit drei Punkten zeigt trotzdem nur, was Dana geändert hat. Startet in einem zweiten Terminal die API mit `npm run dev:api` (http://localhost:4780). Die Web-App braucht ihr nicht.

### 2. Legt den Security-Subagent an

Startet in diesem Ordner eine neue Session und schickt:

```text
Lege einen Subagent security-reviewer an, als Datei .claude/agents/security-reviewer.md. Er darf nur lesen (Read, Grep, Glob), nicht ändern. Er prüft einen Diff auf Sicherheitslücken und nennt zu jedem Fund Schweregrad, Datei und Zeile, wie man ihn ausnutzt, und einen Korrekturvorschlag.
```

Claude schreibt die Datei. Eine Session liest Subagents beim Start, deshalb braucht ihr danach eine neue.

### 3. Lasst Claude die Änderung erklären

Startet eine neue Session und schickt:

```text
Erkläre mir die Änderungen von main...review/admin-export-v2: Was tut das Feature, wer benutzt es, welche Dateien sind betroffen? Führe auch npm test aus.
```

Ihr bekommt eine Zusammenfassung, und die Tests sind grün. Grün heißt nur, dass besteht, was getestet wird.

### 4. Startet das Korrektheits-Review

```text
/code-review main...review/admin-export-v2
```

Das dauert etwas. Lest währenddessen den Diff selbst (`git diff main...review/admin-export-v2` im Terminal) und notiert, was ihr bemängeln würdet.

### 5. Ruft den Security-Subagent

```text
@agent-security-reviewer prüfe die Änderungen von main...review/admin-export-v2. Gib ihm den Diff mit.
```

Der Subagent liest in seinem eigenen Kontext, nur sein Bericht kommt zurück.

### 6. Prüft selbst am laufenden Code

Ein Diff zeigt, was sich ändert, nicht, wie das Feature benutzt wird. Schreibt selbst einen Prompt, der Claude Danas Annahmen am laufenden Code prüfen lässt, nicht nur im Diff, und der verbietet, etwas zu ändern.

Zum Beispiel:

```text
Welche Annahmen macht Danas Code? Prüfe jede am laufenden Code, nicht nur im Diff. Ändere nichts.
```

### 7. Triagiert und reproduziert

**Triage** heißt, jedem Finding ein Urteil zu geben: echt, falsch positiv oder diskutieren. Schickt:

```text
Fasse alle Findings aus dieser Session in einer Tabelle zusammen: Finding, Quelle, Urteil (echt, falsch positiv oder diskutieren), Schweregrad, Begründung. Urteile nur "echt", wenn du es am laufenden Code nachgewiesen hast.
```

Ergänzt eure eigene Liste und alles, was in der Tabelle fehlt. Für das schwerste „echt“ schickt:

```text
Zeig mir für das schwerste echte Finding einen Aufruf, den ich selbst im Terminal ausführen kann, damit ich es mit eigenen Augen sehe. Die API läuft schon. Führ ihn einmal aus und zeig die Ausgabe.
```

Führt den Aufruf selbst im Terminal aus. Claude kann dabei Testdaten anlegen. Beendet die API und führt `npm run db:reset` aus, dann sind sie weg.

### 8. Schreibt das Review für Dana

```text
Schreib aus der Tabelle ein Review für Dana, so wie ich es im Pull Request posten würde: blockierende Punkte zuerst, jeweils mit einem Korrekturvorschlag, danach nicht blockierende Anmerkungen. Am Ende ein Satz: freigeben oder nicht, und warum. Ändere keinen Code.
```

Überarbeitet den Entwurf in euren Worten.

### Was gerade passiert ist

Drei Reviewer haben denselben Diff gelesen: `/code-review`, der Subagent und ihr. Jeder findet etwas anderes, und jeder kann etwas Falsches behaupten. Ein Finding ist erst ein Hinweis, erst die Reproduktion macht es zum Urteil. Wer den Pull Request freigibt, ist danach für ihn verantwortlich.

**Fertig, wenn** ihr ein schriftliches Review mit blockierenden Punkten zuerst habt, mindestens ein Finding selbst im Terminal reproduziert habt und sagen könnt, ob ihr den PR freigeben würdet.

<details>
<summary>Mehr dazu</summary>

- `/code-review` (Effort-Stufen, `--fix`, `--comment`): https://code.claude.com/docs/en/code-review-local
- `/security-review` (laut Docs gegen den Default-Branch von `origin`): https://code.claude.com/docs/en/commands
- Subagents: https://code.claude.com/docs/en/sub-agents
- OWASP Top Ten: https://owasp.org/www-project-top-ten/

</details>
