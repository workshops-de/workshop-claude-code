## Überblick

Baut eure Projekt-Anweisungen über eine einzelne `CLAUDE.md` hinaus aus: Teilt Anweisungen in
fokussierte **Regeldateien** auf, beschränkt manche davon auf die Dateien, die sie betreffen, und
holt gemeinsame Dokumente per **Imports** herein. Damit legt ihr eure Fachsprache und den
API-Vertrag fest, sodass jede künftige Session sie spricht, ohne den Kontext jedes einzelnen Prompts
aufzublähen.

## Das Feature

Claude Code lädt mehr als eine Memory-Datei:

- **`.claude/rules/*.md`**: ein Thema pro Datei (z. B. `domain.md`, `testing.md`). Regeln ohne
  Frontmatter werden beim Start geladen, genau wie `CLAUDE.md`. Dateien werden rekursiv gefunden,
  Unterordner wie `frontend/` funktionieren also auch.
- **Pfadbezogene Regeln**: Ergänzt ein `paths`-Feld, dann wird die Regel nur geladen, wenn Claude
  passende Dateien liest:

  ```markdown
  ---
  paths:
    - "lib/api*"
    - "lib/api/**"
  ---

  # API-Client-Regeln
  - Bücher werden über die ISBN angesprochen, nie über `id`
  ```

- **Imports**: `@path/to/file` in der `CLAUDE.md` fügt eine andere Datei beim Start in den Kontext
  ein (relativ zur importierenden Datei, bis zu vier Ebenen tief). Imports ordnen das Gedächtnis,
  senken aber nicht seine Kosten, denn importierte Dateien werden ebenfalls beim Start geladen.
- **`/memory`** listet jede aktive Memory-Datei auf und öffnet eine davon im Editor; **`/context`**
  zeigt, welche `CLAUDE.md`- und Regeldateien tatsächlich in die aktuelle Session geladen wurden.

Faustregel: Immer relevante Fakten gehören in die `CLAUDE.md` oder eine Regel ohne Pfadbezug;
bereichsspezifische Konventionen in eine pfadbezogene Regel.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Das Übungsfeld ist die **Fachdomäne und der API-Vertrag** von BookMonkey. Die `bookmonkey-api`
wirkt einfach, hat aber Fallen, in die ein Agent gern tappt: Ein Buch hat sowohl eine
vom Server erzeugte `id` als auch eine `isbn`, doch jede Detail-Route wird über die ISBN
angesprochen. `price` ist eine Zahl mit separater `currency`. Bücher einer Reihe verweisen über
`predecessorIsbn` / `successorIsbn` aufeinander. `createdAt` / `updatedAt` verwaltet der Server und
sie dürfen nicht mitgeschickt werden. Der Login liefert ein Token, das kein Endpoint prüft.

Diese Sprache vereinbart ihr einmal und legt sie dort ab, wo jede Session sie lesen kann. Der
Vertrag selbst ist das OpenAPI-Dokument, das die API unter `/api-json` ausliefert, derselbe Vertrag,
den euer eigenes Backend später einhalten muss.

## Schritte

1. Speichert bei laufender API den Vertrag: `curl -s http://localhost:4730/api-json >
   docs/openapi.json`.
2. Lasst den Agenten die Domäne **mit eigenen Worten wiedergeben**, auf Basis von
   `docs/openapi.json` und ein paar echten Antworten (`GET /books?_limit=3`, `GET /books/<isbn>`):
   Entitäten, Felder, Beziehungen und was der Server verwaltet. Korrigiert Abweichungen.
3. Lasst ihn Begriffe auflisten, die unklar sind oder verwechselt werden könnten (`id` vs. `isbn`,
   Autor vs. Co-Autoren, Vorgänger vs. Nachfolger), und löst jeden in eine vereinbarte Definition
   auf. Ergänzt jetzt den Begriff **Leseliste** mit ihren Zuständen *want to read → reading →
   finished*; sie baut ihr in der Hooks-Aufgabe.
4. Lasst den Agenten das Ergebnis in **`.claude/rules/domain.md`** schreiben: Glossar, Entitätsmodell
   und Einschränkungen wie „ISBN ist eindeutig: ein doppeltes `POST /books` liefert `409`“. Wenn ihr das
   live ausprobiert, denkt daran, dass die API geteilter Zustand ist: `curl -X POST
   http://localhost:4730/dev/reset` stellt die 50 Seed-Bücher wieder her.
5. Lasst ihn eine **kompakte** `docs/api-contract.md` schreiben (Endpoints, Query-Parameter,
   Statuscodes; ein Bildschirm, nicht das ganze JSON) und sie in der `CLAUDE.md` mit
   `@docs/api-contract.md` **importieren**. Legt die `CLAUDE.md` an, falls sie fehlt, und ergänzt
   neben diesem Import `@AGENTS.md`: `create-next-app` hat eine `AGENTS.md` erzeugt, und Claude Code
   liest sie nicht mehr, sobald es eine `CLAUDE.md` gibt.
6. Fügt eine **pfadbezogene Regel** `.claude/rules/api-client.md` hinzu, deren `paths` auf euren
   API-Client-Code zeigen (im Scaffold aus der Plan-Mode-Aufgabe ist das `lib/api.ts`, es gibt kein
   `src/`). Sie enthält die Konventionen, die nur dort zählen (per ISBN ansprechen, nie
   servergeführte Felder senden, `X-Total-Count` fürs Paging lesen, `docs/openapi.json` ist die
   Quelle der Wahrheit).
7. Startet eine frische Session und führt `/context` aus: Prüft, dass `domain.md` und der
   importierte Vertrag geladen wurden und `api-client.md` **nicht**. Stellt dann eine Domänenfrage
   und prüft, ob die Antwort euer Glossar verwendet.

## Erfolgskriterien

**Feature**

- [ ] `.claude/rules/domain.md` existiert und wird in einer frischen Session geladen (sichtbar in `/context`)
- [ ] `CLAUDE.md` importiert `docs/api-contract.md` per `@`
- [ ] Mindestens eine Regel ist per `paths`-Frontmatter pfadbezogen und bleibt ungeladen, bis eine
      passende Datei gelesen wird
- [ ] Ihr könnt erklären, warum ihr eine kompakte Zusammenfassung statt der rohen `openapi.json` importiert habt

**Domänenmodell**

- [ ] Das Glossar benennt jede Kernentität (Buch, User, Reihe, Leseliste) mit einer vereinbarten Definition
- [ ] `id` vs. `isbn` und die servergeführten Felder sind ausdrücklich festgehalten
- [ ] Die ISBN-Eindeutigkeit und die Zustände der Leseliste sind festgehalten

## Referenzen

- Claude Code: Memory, rules and imports: https://code.claude.com/docs/en/memory
- Claude Code: Path-specific rules: https://code.claude.com/docs/en/memory#path-specific-rules
- BookMonkey API (README and querying guide): https://github.com/workshops-de/bookmonkey-api
- Ubiquitous language: https://martinfowler.com/bliki/UbiquitousLanguage.html
