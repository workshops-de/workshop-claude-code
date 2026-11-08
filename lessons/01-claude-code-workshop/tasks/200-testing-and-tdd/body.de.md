## Überblick

Übt **Test-Driven Development** mit einem Agenten und nutzt Tests als eingebautes „Fertig“-Signal.
Ihr haltet das Verhalten der fertigen API in Contract-Tests fest, startet dann euer **eigenes
Backend** und treibt es Test für Test voran, bis es sich genauso verhält.

## Das Feature

Agenten schreiben gute Tests und können sie selbst ausführen. Damit sind Tests die
zuverlässigste Feedbackschleife, die ihnen zur Verfügung steht. Aber TDD machen sie nur dann
zuverlässig, wenn ihr es ausdrücklich verlangt:

- **Sagt es und trennt die Phasen**: „Use TDD. Schreibe zuerst fehlschlagende Tests für X. Schreibe
  noch keine Implementierung.“ Prüft die Tests, führt sie aus, seht sie fehlschlagen; erst dann
  bittet ihr um die Implementierung.
- **Lasst den Agenten Randfälle suchen**, bevor er implementiert: Er soll sie aufzählen, dann
  ergänzt ihr die, die er übersehen hat.
- **Schützt die Tests**: Sagt dem Agenten, dass er Tests nicht ändern darf, um sie grün zu machen.
  Ein `PreToolUse`-Hook aus der Hooks-Aufgabe kann das für euren Test-Ordner erzwingen. Er sollte
  nur Änderungen an **bestehenden** Testdateien blockieren, damit ihr weiter neue anlegen könnt
  (die Test-Suite erweitert ihr in der Aufgabe zu autonomen Workflows).
- **Ein Gate-Befehl** (Type-Check, Lint, Build, Tests), den der Agent selbstständig ausführen kann
  und der in der `CLAUDE.md` steht, damit jede Session weiß, was „fertig“ bedeutet.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730, euer NestJS-Backend auf
> http://localhost:3001
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Bisher spricht euer Frontend mit der fertigen `bookmonkey-api`. Jetzt ersetzt ihr sie Schritt für
Schritt durch ein eigenes **NestJS**-Backend, ohne das Frontend kaputt zu machen. Das Sicherheitsnetz
ist eine **Contract-Test-Suite**, die nur über HTTP spricht und ihre Basis-URL aus `API_URL` liest:

- Läuft sie gegen `http://localhost:4730`, dokumentiert die Suite, wie sich die Referenz-API
  verhält. Schlägt dort ein Test fehl, ist der Test falsch, nicht die API.
- Läuft sie gegen euer Backend, zeigt dieselbe Suite dem Agenten genau, was noch fehlt.

`docs/openapi.json` aus der Rules-Aufgabe ist der Vertrag, den beide Seiten teilen.

## Voraussetzungen

- Die `bookmonkey-api` läuft auf Port 4730; `docs/openapi.json` ist committet.
- Die NestJS-CLI ist über `npx @nestjs/cli` verfügbar (keine globale Installation nötig).
- Optionale Skills, falls ihr Prisma + SQLite für die Persistenz wählt:
  `npx skills add prisma/skills@prisma-cli -y` und `npx skills add prisma/skills@prisma-database-setup -y`.

## Schritte

1. Bittet den Agenten, ein Package `contract-tests/` einzurichten (Vitest + `fetch` oder
   `supertest` gegen eine URL), das `API_URL` liest. Weist ihn an, **TDD** zu nutzen: Tests für
   `GET /books/:isbn` (200 mit der Buchstruktur, 404 bei unbekannter ISBN) und `POST /books` (201,
   vom Server gesetzte `id` / `createdAt` / `updatedAt`, **409 bei doppelter ISBN**, 400 bei
   fehlendem Titel) schreiben, nirgends eine Implementierung. Legt ein Root-Skript an, damit ein
   Befehl die Suite ausführt (die Aufgabe zu autonomen Workflows setzt darauf auf):
   `"contract": "cd contract-tests && npx vitest run"` in der Root-`package.json`, verwendet als
   `API_URL=http://localhost:4730 npm run contract`.
2. Prüft die Tests, bittet den Agenten, weitere **Randfälle** aufzuzählen, und ergänzt die, die er
   übersehen hat. Führt die Suite gegen die Referenz-API aus: Alles muss grün sein. Korrigiert die
   Tests, nie die API.
3. Richtet das Backend im Plan Mode ein:
   `npx @nestjs/cli new backend --package-manager npm --skip-git` (ohne die Flags wartet die CLI auf
   eine Abfrage zum Paketmanager und legt ein verschachteltes Git-Repository an), mit einem
   Books-Modul und einer Persistenz-Entscheidung, die ihr begründen könnt (SQLite über Prisma ist
   ein guter Standard). Nutzt eine Wegwerf-Testdatenbank, nie eure Entwicklungsdaten. NestJS 12
   erzeugt **ESM mit Vitest und oxlint**; ältere Tutorials mit Jest und CommonJS passen nicht. Der
   „Hello World“-E2E-Test für die Beispielroute `GET /` wird rot, sobald ihr die Beispielroute
   entfernt: Löscht oder passt ihn an.
   Bevor ihr das Backend zum ersten Mal ändert, **beschränkt das Frontend-Tooling auf das
   Frontend**: Fügt `"exclude": ["node_modules", "backend", "contract-tests"]` in die
   Root-`tsconfig.json` ein und ignoriert beide Ordner in der Root-`eslint.config.mjs`. Sonst lässt
   der Type-Check-Hook aus der Hooks-Aufgabe das Root-`tsc` über die neuen Packages laufen und
   scheitert (`TS1241`, `TS2582 Cannot find name 'describe'`).
4. Führt die Contract-Suite gegen euer Backend aus (`API_URL=http://localhost:3001`) und seht sie
   fehlschlagen. Lasst den Agenten dann **gerade genug** implementieren, damit die Tests aus
   Schritt 1 grün werden, und sagt ihm, dass er die Tests nicht anfassen darf.
5. Bindet die **Quality Gates** (Type-Check, Lint, Build, Unit-Tests, Contract-Tests) in einen
   Befehl ein und haltet ihn im Projekt-Memory fest.
6. Reflektiert: Wie hat eine lauffähige, fehlschlagende Test-Suite das Verhalten des Agenten
   verändert, verglichen mit einer Anfrage in Textform?

## Erfolgskriterien

**Feature**

- [ ] Die Tests wurden geschrieben und geprüft, bevor es irgendeine Backend-Implementierung gab
- [ ] Ihr habt mindestens einen Randfall ergänzt, an den der Agent nicht gedacht hat
- [ ] Der Agent hat gegen fehlschlagende Tests implementiert, ohne sie zu ändern
- [ ] Ein einzelner Befehl führt alle Quality Gates aus und steht in der `CLAUDE.md`

**App funktioniert weiterhin**

- [ ] Die Contract-Suite ist grün gegen die Referenz-API auf Port 4730
- [ ] Dieselbe Suite ist für `GET /books/:isbn` und `POST /books` gegen euer NestJS-Backend grün
- [ ] Das Frontend läuft unverändert weiter gegen die Referenz-API

## Referenzen

- Claude Code: Common workflows (testing): https://code.claude.com/docs/en/common-workflows
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- NestJS: First steps: https://docs.nestjs.com/first-steps
- Vitest: Getting started: https://vitest.dev/guide/
- Consumer-driven contracts (Martin Fowler): https://martinfowler.com/articles/consumerDrivenContracts.html
