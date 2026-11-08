## Lernziele

- **Feature:** eingebaute vs. eigene Subagents, `.claude/agents/`-Dateien und Frontmatter
  (`description`, `tools`, `model`), automatischer vs. expliziter Aufruf (`@agent-…`,
  `claude --agent`).
- **Konzepte:** Kontext-Isolation; Delegation für lautes Arbeiten; Tools passend zur Aufgabe
  einschränken.
- **Übungsfeld:** BookMonkey-Anmeldung gegen die fertige API, geprüft von einem schreibgeschützten
  Security-Subagent.
- **Takeaways:** Lautes Arbeiten aus dem Haupt-Kontext auslagern; ein Reviewer liefert Input, die
  Entscheidung liegt bei euch.

## Hinweise zur Durchführung

- Der Vorher/Nachher-Vergleich mit `/context` überzeugt von der Kontext-Isolation – sorgt dafür, dass
  die Leute ihn wirklich ausführen und nicht nur darüber lesen.
- Seit v2.1.198 öffnet `/agents` keinen Erstellungs-Wizard mehr; Teilnehmende erstellen Subagents,
  indem sie Claude bitten oder die Datei schreiben. Ältere Screenshots oder Blogposts zeigen noch den
  Wizard.
- Das nicht erzwungene Token ist das eingebaute Finding. Findet es kein Reviewer, fragt den Raum:
  „Was hindert mich daran, ein Buch zu löschen, ohne angemeldet zu sein?“ – und verweist dann auf
  die Aufgaben 200/230, in denen das eigene Backend die Lücke schließt.
- Ein zweites echtes Finding aus dem Probelauf: `POST /login` und `POST /register` liefern den
  **Passwort-Hash** innerhalb von `user`. Gutes Material für die Kategorie „kann nur das Backend
  beheben“.
- Im Probelauf wurde der Reviewer direkt nach dem Schreiben seiner Datei nicht gefunden (`Agent type
  'security-reviewer' not found`), weil `.claude/agents/` beim Session-Start nicht existierte. Der
  Neustart in Schritt 3 behebt das.
- Ein Reviewer mit `Bash` ist nicht mehr schreibgeschützt. Haltet ihn bei `Read, Grep, Glob` und lasst
  die Haupt-Session den `curl`-Test ausführen (Schritt 4). Der Reviewer mit Bash hat im Probelauf
  wirklich ein Buch gelöscht und einen User registriert, deshalb ist `POST /dev/reset` danach nicht
  optional.
- Jemand wird das Token in `localStorage` ablegen, weil es schneller geht. Lasst den Reviewer das
  finden.
- Widersteht dem Abnicken in beide Richtungen: Weder der Implementierungs-Diff noch die Findings des
  Reviewers sollten ungelesen akzeptiert werden. Bittet eine Person, den Raum durch ihre Triage zu führen.
- Gelöschte Seed-Bücher: `POST /dev/reset` stellt sie für alle auf dieser API-Instanz wieder her.

## Zeitbedarf

~50 Minuten.
