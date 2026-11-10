In dieser Aufgabe geht es um **autonome Läufe mit `/goal`**: Ihr nennt Claude eine Bedingung, die sich prüfen lässt, und Claude arbeitet Runde für Runde selbst daran, bis sie erfüllt ist. Dabei stellt es euer NestJS-Backend gegen die Contract-Tests fertig, in einem eigenen **Worktree** (ein zweiter Arbeitsordner mit eigenem Branch, so bleibt euer Hauptordner unberührt).

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26. Startet in einem Terminal die API mit `npx bookmonkey-api` (http://localhost:4730) und in einem zweiten das Backend mit `cd backend && npm run start:dev` (http://localhost:3001).

### 1. Schreibt das Ziel als Tests

Euer Backend kann bisher nur einzelne Bücher lesen, anlegen und löschen. Claude soll die Liste `GET /books` bauen, und ihr legt vorher fest, wann sie fertig ist. Schreibt den Prompt selbst: Claude soll Contract-Tests für Suche (`q`), Paging (`_page`, `_limit`), Sortierung (`_sort`, `_order`) und den Header `X-Total-Count` ergänzen und sie gegen die Referenz-API auf Port 4730 prüfen.

Setzt vorher die Daten der API zurück, denn in der Skill-Aufgabe habt ihr dort Bücher angelegt: `curl -X POST http://localhost:4730/dev/reset`.

Zum Beispiel:

```text
Ergänze die Contract-Tests um GET /books: die Suche mit q, das Paging mit _page und _limit, die Sortierung mit _sort und _order und den Header X-Total-Count. Die Referenz-API hat 50 Bücher, ein Test soll das prüfen. Führe die Tests gegen http://localhost:4730 aus. Schlägt ein neuer Test fehl, korrigiere den Test, nicht die API. Ändere nichts am Backend.
```

In unserem Lauf kamen 14 neue Tests dazu, alle grün gegen die API.

### 2. Committet die Tests

Ein Worktree startet beim letzten Commit, ungesicherte Dateien fehlen dort.

```text
Committe die neuen Contract-Tests. Lies vorher den Diff.
```

### 3. Seht die Tests rot

Führt im Root-Ordner `API_URL=http://localhost:3001 npm run contract` aus (PowerShell: `$env:API_URL="http://localhost:3001"; npm run contract`). In unserem Lauf scheiterten 14 von 31 Tests.

### 4. Gebt Claude das Ziel

Stoppt das Backend im zweiten Terminal, Claude startet im Worktree sein eigenes. Öffnet in der Desktop-App das Terminal im Projektordner und startet dort `claude --worktree contract-run --permission-mode auto`. Der **Auto-Modus** sorgt dafür, dass Claude nicht bei jedem Befehl fragt. Schickt dort:

```text
/goal npm run contract mit API_URL=http://localhost:3001 endet mit Exit-Code 0. Installiere zuerst die Abhängigkeiten in backend/ und contract-tests/. Starte das Backend aus diesem Ordner selbst mit PORT=3001 und beende es danach wieder. Die Daten bleiben im Speicher: Beim Start lädt das Backend alle Bücher von http://localhost:4730/books. Dateien unter contract-tests/ bleiben unverändert. Stopp nach 20 Turns.
```

Das Ziel hat drei Teile: ein messbarer Endzustand, eine Randbedingung (die Tests bleiben, wie sie sind) und eine Obergrenze für die Runden (Turns). Danach arbeitet Claude ohne Rückfragen. In unserem Lauf waren es 17 Schritte in knapp drei Minuten. Der Typecheck-Hook meldete dabei `PageProps` und `LayoutProps` aus dem Frontend, das hat mit dem Backend nichts zu tun.

### 5. Lest den Diff, dann sichert ihn

Schaut euch zuerst selbst an, was Claude geändert hat. Schickt dann in derselben Session:

```text
Lies den Diff in diesem Worktree und fasse in drei Sätzen zusammen, was geändert wurde und was die Contract-Tests nicht abdecken. Committe die Änderungen danach auf diesem Branch.
```

### 6. Übernehmt die Arbeit

Das ist euer Kontrollpunkt: Nur was ihr gelesen habt und verantworten würdet, kommt in `main`. Beendet die Session im Terminal mit `/exit`. Fragt Claude Code, ob der Worktree bleiben soll, behaltet ihn. Startet dann eine neue Session im Hauptordner und schickt:

```text
Merge den Branch worktree-contract-run in main und räume danach den Worktree auf.
```

### 7. Schaltet die Anwendung um

Startet das Backend wieder (`cd backend && npm run start:dev`). Setzt in `.env.local` `NEXT_PUBLIC_API_URL=http://localhost:3001`, startet `npm run dev` neu und öffnet http://localhost:3000/books. Der Katalog zeigt jetzt die Bücher aus eurem eigenen Backend. In unserem Lauf kamen die Cover weiter von der API auf Port 4730, weil das Backend ihre Adressen übernommen hat, und `/login` antwortete mit 404. Anmelden geht dann erst wieder, wenn ihr den Wert zurück auf http://localhost:4730 setzt.

### Was gerade passiert ist

Die Contract-Tests waren das Ziel, `/goal` hat Claude dort gehalten, bis sie grün waren. Der **Auto-Modus** nimmt die Rückfragen pro Befehl weg, `/goal` die Rückfragen pro Runde. Beides läuft unabhängig voneinander. Grün heißt nur, dass der Vertrag erfüllt ist: Die Anmeldung stand nicht darin, deshalb fehlt sie. Wer das Ziel definiert, bestimmt, was am Ende fertig ist.

**Fertig, wenn** `npm run contract` gegen Port 4730 und gegen euer Backend auf Port 3001 grün ist, der Branch gemergt ist und der Katalog Bücher von eurem Backend zeigt.

<details>
<summary>Mehr dazu</summary>

Die Desktop-App hat laut [Docs](https://code.claude.com/docs/en/worktrees) eine eigene Option für Worktrees. Laut Docs prüft nach jeder Runde ein separates Modell, ob die Bedingung erfüllt ist, und die Obergrenze zählt es nach der Unterhaltung, sie ist kein hartes Limit. `/goal` zeigt den Stand, `/goal clear` bricht ab. `curl -X POST http://localhost:4730/dev/reset` stellt die Daten der API wieder her.

- Goal: https://code.claude.com/docs/en/goal
- Worktrees: https://code.claude.com/docs/en/worktrees
- Permission Modes: https://code.claude.com/docs/en/permission-modes
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api/blob/main/docs/querying.md

</details>
