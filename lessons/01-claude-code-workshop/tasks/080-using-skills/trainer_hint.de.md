## Lernziele

- **Feature:** Skills finden (`npx skills find`), installieren und prüfen; `/skills`;
  automatischer vs. expliziter (`/skill-name`) Aufruf; Progressive Disclosure.
- **Konzepte:** Skills tragen prozedurales, schnelllebiges Wissen bei Bedarf; Memory trägt
  immer relevante Fakten.
- **Übungsfeld:** shadcn/ui-Setup und die BookMonkey-Katalogseite.
- **Takeaways:** Zu einem gepflegten Skill greifen, wenn sich die Library schneller bewegt als das
  Modell; das Ergebnis trotzdem prüfen; vor der Installation prüfen, wer einen Skill veröffentlicht.

## Hinweise zur Durchführung

- Die Katalogsuche ist ein Supply-Chain-Moment: Es gibt mehrere `shadcn`-Skills von verschiedenen
  Publishern. Fragt, warum `shadcn-ui/ui@shadcn` der vertrauenswürdige ist.
- Der Moment, der überzeugt: auf ein shadcn-CLI-Detail zeigen, das der Skill erledigt hat
  (interaktive `init`-Prompts, geänderte Flags), und den Raum fragen, ob der Agent es allein gewusst
  hätte.
- `init` kann auch mit `--yes` noch Rückfragen stellen – Teilnehmende denken oft, der Prozess hänge.
- Achtet auf Karten-Links, die aus der `id` statt der `isbn` gebaut sind – das Glossar aus der
  Regeln-Aufgabe sollte das verhindern; tut es das nicht, ist das eine gute Diskussion über die
  Qualität von Regeln.
- Der Probelauf lief in zwei Fallen: Der mitten in der Session installierte Skill war unbekannt
  (`Unknown skill: shadcn`), bis die Skills neu geladen wurden, weil `.claude/skills/` beim
  Session-Start nicht existierte; und `/shadcn` kann nicht funktionieren, weil der offizielle Skill
  `user-invocable: false` ist. Beides steht jetzt in den Schritten; eine kurze Demo von
  `/reload-skills` lohnt sich trotzdem.
- Die `lib/api.ts` aus der Plan-Mode-Aufgabe liefert meist nur Titel; rechnet damit, dass der Agent
  sie erweitert (Cover, Autor, Preis, Währung). Karten-Links zeigen auf `/books/<isbn>`, was bis zur
  Aufgabe zu Custom Skills ein 404 bleibt, die die Detailseite baut.
- Einen eigenen Skill zu schreiben kommt später (Aufgabe zu Custom Skills) – hier geht es nur ums
  Benutzen.

## Zeitbedarf

~45 Minuten.
