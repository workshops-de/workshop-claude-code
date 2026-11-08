## Lernziele

- **Feature:** `SKILL.md` mit einer Beschreibung voller Triggerwörter schreiben; Commands nur für
  Nutzer über `disable-model-invocation: true`; Argumente mit `$ARGUMENTS`.
- **Konzepte:** Progressive Disclosure; Skill (Agent löst aus) vs. Command (ihr löst aus) vs.
  Memory (immer geladen); Commands sind in Skills aufgegangen.
- **Übungsfeld:** die Leseseite von BookMonkey (Suche, Sortierung, Paging, Navigation durch
  Reihen) von Hand, danach die Create- und Edit-Screens aus dem festgehaltenen Muster.
- **Erkenntnisse:** einmal von Hand bauen, festhalten, dann die Festschreibung die nächsten
  erledigen lassen.

## Hinweise zur Durchführung

- Das ist die größte Aufgabe – erwägt, die Leseseite gemeinsam in der Gruppe live zu bauen, damit
  die Teilnehmenden ihre Einzelzeit für Skill und Command nutzen.
- Lasst niemanden den Check in der „frischen Session“ überspringen; echtes automatisches Laden
  ist der Beweis.
- Der Unterschied zwischen Skill und Command bringt Leute ins Straucheln; haltet Beispiele bereit
  („Commit-Nachricht“ = Command, „einen Buch-Screen auf die etablierte Art hinzufügen“ = Skill).
- Ältere Materialien zeigen `.claude/commands/` als einzigen Weg für Commands – beides
  funktioniert, Skills sind das aktuelle Format.
- Paging braucht den Response-Header `X-Total-Count` – Agenten leiten „gibt es eine nächste Seite“
  oft aus der Länge des Arrays ab. Guter Moment fürs Review.
- Paging-Check: Eine Suche nach „harry“ hat nur 7 Treffer, also gibt es keine Seite 2. Testet das
  Paging ohne Suche (50 Bücher) oder mit einem breiteren Begriff.
- Wenn ihr den Katalog-Client ändert (zum Beispiel `getBooks(limit)` zu
  `getBooks({ q, sort, page })`), bricht die Startseite aus der Plan-Mode-Aufgabe mit einem
  Typfehler. Das ist erwartet; lasst den Agenten den Aufrufer reparieren.
- Im Probelauf wurde die Beispielbeschreibung in einer frischen Session nicht erkannt; eine
  Version, die mit Triggerwörtern begann („book, books, book detail page, catalogue, page count,
  price“), wurde erkannt. Genau diese Verfeinerung verlangt Schritt 3.
- Angelegte Bücher bleiben in der gemeinsamen API-Instanz; `POST /dev/reset` räumt zwischen den
  Gruppen auf.
- Liegt die Gruppe zurück, kürzt den Command-Lauf auf den Create-Screen.

## Zeitbedarf

~60 Minuten.
