## Überblick

Bringt alles zusammen, was ihr über Berechtigungen, Sicherheit und Kontext gelernt habt, und lasst
**längere, weniger beaufsichtigte** Arbeit laufen. Kombiniert den Auto Mode (oder ein vorab
freigegebenes Tool-Set) mit einem **Ziel**, auf das Claude hinarbeitet, in einem **isolierten
Worktree** – und behaltet dort einen Menschen im Loop, wo es darauf ankommt.

## Das Feature

„Autonom“ heißt nicht „für immer unbeaufsichtigt“. Es heißt, den Agenten so aufzusetzen, dass er
Routineentscheidungen innerhalb der von euch definierten Grenzen selbst trifft – und ihr danach das
Ergebnis prüft.

- **`/goal <condition>`**: Nach jedem Turn prüft ein separates Evaluator-Modell die Bedingung; gilt
  sie noch nicht, startet Claude den nächsten Turn von selbst. Formuliert sie so, dass Claudes
  eigene Ausgabe sie belegen kann: ein messbarer Endzustand, eine genannte Prüfung, Randbedingungen
  und eine Obergrenze:

  ```text
  /goal npm run contract against API_URL=http://localhost:3001 exits 0,
  no file under contract-tests/ is modified, or stop after 30 turns
  ```

  `/goal` zeigt den Status, `/goal clear` stoppt es. Die Turn-Obergrenze ist kein hartes Limit: Der
  Evaluator beurteilt sie anhand der Unterhaltung, wie den Rest der Bedingung. (Nur nicht
  interaktive `claude -p`-Läufe haben ein hartes Limit, `--max-turns`.)
- **Auto Mode** (oder ein kuratiertes `--allowedTools`-Set / `acceptEdits`) entfernt die Rückfragen
  pro Tool; `/goal` entfernt die Rückfragen pro Turn. Beides ergänzt sich: Ein Ziel ändert euren
  Permission Mode nicht.
- **Isolation**: `claude --worktree <name>` startet die Session in einem eigenen Git-Worktree unter
  `.claude/worktrees/<name>/` auf einem neuen Branch namens `worktree-<name>`. So bleibt euer
  Haupt-Checkout unberührt, bis ihr geprüft und gemergt habt. Tragt `.claude/worktrees/` in die
  `.gitignore` ein.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730, euer NestJS-Backend auf
> http://localhost:3001
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

In der TDD-Aufgabe hat euer NestJS-Backend zwei Endpoints gelernt. Übungsfeld ist jetzt: es **ohne Handführung gegen den Vertrag fertigstellen**: die komplette Query-Oberfläche von
`GET /books` (`q`, `_page`, `_limit`, `_sort`, `_order`, der `X-Total-Count`-Header), `PUT` /
`PATCH` / `DELETE`, `/register` und `/login`, `/dev/reset` und die 50 Seed-Bücher. Die
Contract-Test-Suite ist der messbare Endzustand des Ziels. Ist sie grün, richtet ihr das Frontend
auf euer eigenes Backend: der Moment der Wahrheit für die gesamte Workshop-App.

## Voraussetzungen

- Die Contract-Test-Suite, das Skript `npm run contract` und das NestJS-Backend aus der
  TDD-Aufgabe sind committet.
- Die Seed-Daten der Referenz-API: `npm i -D bookmonkey-api`, dann
  `node_modules/bookmonkey-api/dist/assets/db-original.json` lesen (50 Bücher und der Demo-User).
  Die Cover-Bilder liegen in `node_modules/bookmonkey-api/dist/assets/public/covers/`; das Frontend
  lädt sie von `<API_URL>/covers/<isbn>.png`, euer Backend muss sie also ebenfalls ausliefern.
- Der Demo-User `admin@bookmonkey.api` / `password1!` muss sich an eurem Backend anmelden können.
  Sein Seed-Passwort ist ein bcrypt-Hash, prüft also mit bcrypt (oder hasht es beim Seeden neu).

## Schritte

1. Erweitert zuerst die Contract-Test-Suite (in eurem Haupt-Checkout, von euch geprüft), sodass sie
   die übrigen Endpoints abdeckt. Bestätigt, dass sie gegen die Referenz-API auf Port 4730 grün ist,
   und committet sie. Falls euer protect-tests-Hook aus der TDD-Aufgabe jede Datei unter
   `contract-tests/` blockiert, blockiert er auch diese **neuen** Dateien: Ändert ihn so, dass er
   nur bestehende Dateien blockiert (siehe Bonus der TDD-Aufgabe), statt ihn zu umgehen. Die Suite
   schreibt in die gemeinsame Referenz-API; `curl -X POST http://localhost:4730/dev/reset` stellt
   sie wieder her.
2. Ein Worktree startet normalerweise beim Standard-Branch, ohne eure Arbeit aus Schritt 1. Setzt
   deshalb zuerst `"worktree": {"baseRef": "head"}` in `.claude/settings.json`. Startet dann eine
   isolierte Session: `claude --worktree backend-contract` (Branch `worktree-backend-contract`) und
   wechselt in den Auto Mode (oder startet, falls der Auto Mode nicht verfügbar ist, mit einem
   kuratierten `--allowedTools`-Set). Der Worktree ist ein frischer Checkout ohne `node_modules`: Installiert zuerst die Abhängigkeiten in `backend/` und
   `contract-tests/` oder macht es zum Teil des Ziels.
3. Setzt das **Ziel** mit einer messbaren Bedingung, einer Randbedingung „Tests nicht anfassen“ und
   einer Turn-Obergrenze. Beobachtet die Urteile des Evaluators (`Ctrl+O` zeigt die Begründung).
4. Sobald das Ziel erreicht ist, prüft den Diff im Worktree wie einen Pull Request: Das ist euer
   bewusster **Human-in-the-Loop**-Checkpoint. Mergt nur, was ihr unterschreiben würdet.
5. Richtet das Frontend auf euer Backend (`NEXT_PUBLIC_API_URL=http://localhost:3001`), startet es
   neu und spielt die Browser-Journey aus der MCP-Aufgabe noch einmal durch: Suche und Paging,
   Reihen-Links eines Buchs vorwärts und rückwärts, Anmeldung als Demo-User, Buch anlegen und
   bearbeiten, Cover sichtbar.
6. Reflektiert: Welche eurer echten Aufgaben eignen sich für einen zielgesteuerten Lauf, und welche
   nicht?

## Erfolgskriterien

**Feature**

- [ ] Ein `/goal` mit messbarer Bedingung, Randbedingung und Obergrenze hat den Lauf bis zum Ende
      getragen
- [ ] Der Lauf fand in einem isolierten Worktree statt, mit deutlich weniger Rückfragen als sonst
- [ ] Ihr habt den Diff vor dem Mergen geprüft und könnt den Human-in-the-Loop-Checkpoint benennen
- [ ] Ihr könnt den Unterschied zwischen Auto Mode und `/goal` erklären

**App funktioniert weiterhin**

- [ ] Die komplette Contract-Test-Suite ist sowohl gegen die Referenz-API als auch gegen euer
      Backend grün
- [ ] Das Frontend läuft gegen euer eigenes Backend; Katalog, Navigation durch Reihen, Anmeldung und
      Anlegen/Bearbeiten funktionieren unverändert
- [ ] Euer Backend liefert die 50 Seed-Bücher aus, und `/dev/reset` stellt sie wieder her

## Referenzen

- Claude Code: Keep Claude working toward a goal: https://code.claude.com/docs/en/goal
- Claude Code: Permission modes (auto mode): https://code.claude.com/docs/en/permission-modes
- Claude Code: Run parallel sessions with worktrees: https://code.claude.com/docs/en/worktrees
- BookMonkey API: Querying guide: https://github.com/workshops-de/bookmonkey-api/blob/main/docs/querying.md
