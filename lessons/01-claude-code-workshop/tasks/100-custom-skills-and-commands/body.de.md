## Überblick

Schreibt einen **eigenen Skill** und einen **eigenen Slash Command**, damit die Art, wie euer Team
ein Feature baut, einmal festgehalten ist und überall wiederverwendet wird, ohne sie in jeder
Session neu zu erklären. Ihr baut ein Feature von Hand, haltet seine Form fest und lasst die
nächsten Features aus dem bauen, was ihr festgehalten habt.

## Das Feature

Beide liegen am selben Ort und teilen ein Format: eine `SKILL.md` in `.claude/skills/<name>/`
(ältere Command-Dateien in `.claude/commands/<name>.md` funktionieren weiterhin und erzeugen
dasselbe `/name`). Der Unterschied: **Wer entscheidet, wann es läuft?**

- **Skill (der Agent entscheidet)**: Eine `description` mit passenden Triggerwörtern lässt Claude
  den Skill laden, sobald eine Aufgabe passt:

  ```markdown
  ---
  name: add-book-feature
  description: Use when adding or changing a book screen or book API call - API client function, page, form, server action, revalidation
  ---

  1. Add or extend the typed API client function (address books by ISBN)
  2. Read in a server component; keep filters and paging in the URL
  3. Write through a server action that validates, calls the API, and maps errors
  4. Signed-in screens: add the route to the `proxy.ts` matcher
  5. Revalidate affected paths, then run type-check and npm run build
  ```

- **Command (ihr entscheidet)**: Mit `disable-model-invocation: true` läuft er nur, wenn ihr ihn
  eintippt. Für Eingaben nutzt ihr `$ARGUMENTS` (oder `$0`, `$1`, …):

  ```markdown
  ---
  name: new-book-view
  description: Scaffold a new book screen following the add-book-feature skill
  disable-model-invocation: true
  argument-hint: "[create|edit]"
  ---

  Build the "$ARGUMENTS" book screen following the add-book-feature skill.
  ```

  Speichert ihn als `.claude/skills/new-book-view/SKILL.md` und ruft ihn mit
  `/new-book-view create` auf. (Eine ältere `.claude/commands/new-book-view.md` funktioniert auch,
  aber Command-Dateien kennen das Feld `name` nicht.) Setzt `argument-hint` in Anführungszeichen:
  Eckige Klammern ohne Anführungszeichen sind in YAML eine Liste, kein String.

- **Haltet den Inhalt kurz und handlungsorientiert**: Nummerierte Schritte schlagen Fließtext, und
  ein geladener Skill bleibt für den Rest der Session im Kontext.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Das Übungsfeld sind die **Buch-Screens** von BookMonkey in einer Server-First-Architektur: **Lesen**
in Server Components über euren typisierten API-Client, **Schreiben** über Server Actions, die
validieren, die API aufrufen und revalidieren. Die Leseseite baut ihr von Hand (Katalogsuche,
Sortierung und Paging sowie eine Detailseite, die durch eine Buchreihe navigiert). Die
Schreibseite (anlegen, bearbeiten) lasst ihr aus dem erzeugen, was ihr festgehalten habt. Wenn
euer Skill gut ist, bestehen der zweite und dritte Screen fast nur noch aus Feldern.

## Voraussetzungen

- Die `bookmonkey-api` läuft; die Katalogseite aus der Skills-Aufgabe existiert.
- **Erforderlich:** `find-skills` (`npx skills add vercel-labs/skills@find-skills -y`): Schaut
  euch an, wie bestehende Skills aufgebaut sind, bevor ihr eigene schreibt.
- Optionale Skills (nützlich, aber nicht nötig): `anthropics/skills@frontend-design`,
  `vercel-labs/agent-skills@vercel-react-best-practices`

## Schritte

1. Baut mit dem Agenten die **Leseseite**: Suche (`q`), Sortierung (`_sort`/`_order`) und Paging
   (`_page`/`_limit`, Gesamtzahl aus dem Header `X-Total-Count`) im Katalog, alles in der URL
   gehalten; dazu eine Detailseite unter `/books/<isbn>` mit Links „vorheriges / nächstes in der
   Reihe“ aus `predecessorIsbn` / `successorIsbn`. Prüft jeden Teil im Browser, bevor ihr weitergeht.
2. Schaut zurück auf das, was ihr getan habt, und schreibt **`.claude/skills/add-book-feature/SKILL.md`**:
   die Schritte in der richtigen Reihenfolge, mit einer Beschreibung, die mit Triggerwörtern beginnt.
3. **Testet den Skill in einer frischen Session**: Bittet um eine kleine, passende Änderung (z. B.
   „zeige die Seitenzahl auf der Detailseite an“), ohne den Skill zu nennen, und prüft, ob Claude
   ihn lädt. Verfeinert die Beschreibung, falls nicht. Die Beispielbeschreibung oben ist nur ein
   Ausgangspunkt und wird oft nicht so übernommen: Beginnt mit den Wörtern, die eure Prompts
   enthalten (Buch, Detailseite, Katalog, Feldnamen wie Seitenzahl oder Preis).
4. Schreibt den Command **`/new-book-view`** mit `disable-model-invocation: true` und
   `$ARGUMENTS`.
5. Führt `/new-book-view create` (`POST /books`) und danach `/new-book-view edit` (`PATCH
   /books/<isbn>`) aus. Beide sind nur mit Anmeldung erreichbar, ihre Routen (zum Beispiel
   `/books/new` und `/books/<isbn>/edit`) müssen also im `proxy.ts`-Matcher aus der
   Subagents-Aufgabe stehen. Haltet fest, was sich zwischen beiden unterschied: idealerweise nur der
   HTTP-Aufruf und die Formularvorgaben.
6. Reflektiert: Welche eurer wiederkehrenden Anfragen sind Skills, welche Commands und welche
   gehören in die `CLAUDE.md`?

## Erfolgskriterien

**Feature**

- [ ] `.claude/skills/add-book-feature/SKILL.md` existiert und Claude hat ihn in einer frischen
      Session von selbst geladen
- [ ] Ihr habt die Beschreibung des Skills mindestens einmal anhand des beobachteten Verhaltens
      verfeinert
- [ ] Ein Command nur für euch nimmt ein Argument entgegen und hat sowohl den Create- als auch den
      Edit-Screen gebaut
- [ ] Ihr könnt Skill, Command und `CLAUDE.md` in eigenen Worten voneinander abgrenzen

**App funktioniert weiterhin**

- [ ] Suche, Sortierung und Paging überstehen ein Neuladen der Seite (der Zustand liegt in der URL)
- [ ] Die Detailseite navigiert in beide Richtungen durch eine Reihe (z. B. die Harry-Potter-Bücher)
- [ ] Ein Buch mit bereits vorhandener ISBN zeigt eine klare Meldung für das `409` der API statt
      eines Absturzes
- [ ] Edit sendet nie `id`, `createdAt` oder `updatedAt`; Type-Check und `npm run build` laufen
      durch

## Stolperfallen (aktuelles Framework)

- `params` und `searchParams` sind in aktuellen Next.js-Versionen **Promises**: In Seiten mit
  `await` auflösen.
- Ergebnisse von serverseitigem `fetch` können gecacht sein: Stellt sicher, dass die Liste ein
  frisch angelegtes Buch zeigt.
- Eine ISBN an eine Server Action binden, ohne die Signatur `(prev, formData)` zu verlieren:
  `action.bind(null, isbn)`.
- Route-Type-Helper wie `PageProps<"/books/[isbn]">` gibt es erst, nachdem `next dev` oder
  `next build` die Route-Typen erzeugt hat; bis dahin meldet `tsc` `TS2344`.
- `/books/new` (Gruppe mit Anmeldung) und `/books/[isbn]` (öffentliche Gruppe) teilen sich einen
  URL-Raum. Das statische Segment `new` gewinnt, es funktioniert also, aber denkt daran, falls
  eine Route zu verschwinden scheint.

## Referenzen

- Claude Code: Skills: https://code.claude.com/docs/en/skills
- Claude Code: Control who invokes a skill: https://code.claude.com/docs/en/skills#control-who-invokes-a-skill
- Claude Code: Pass arguments to skills: https://code.claude.com/docs/en/skills#pass-arguments-to-skills
- BookMonkey API: Querying guide: https://github.com/workshops-de/bookmonkey-api/blob/main/docs/querying.md
- Next.js: Server Actions and mutations: https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations
