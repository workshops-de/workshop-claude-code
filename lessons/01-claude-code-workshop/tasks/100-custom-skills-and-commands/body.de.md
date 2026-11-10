In dieser Aufgabe geht es um einen **eigenen Skill** (eine Anleitung, die Claude selbst lädt, wenn sie zur Aufgabe passt) und einen **eigenen Befehl** (ein Slash Command, den nur ihr startet). Ihr baut eine Seite von Hand, haltet fest, wie sie gebaut wurde, und lasst die nächsten Seiten daraus entstehen.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26. Die API (`npx bookmonkey-api`) läuft auf http://localhost:4730, die App startet ihr mit `npm run dev` auf http://localhost:3000. Der Demo-User ist `admin@bookmonkey.api` mit `password1!`.

### 1. Baut die Leseseite von Hand

```text
Baue die Leseseite des Katalogs. Auf /books: ein Suchfeld (q), Sortierung nach Titel oder Preis (_sort, _order) und Paging mit 12 Büchern pro Seite (_page, _limit, Gesamtzahl aus dem Header X-Total-Count). Alles bleibt in der URL. Dazu eine Detailseite unter /books/<isbn> mit den Links vorheriges und nächstes Buch der Reihe, aus predecessorIsbn und successorIsbn. Prüfe mit npm run build.
```

Öffnet danach `/books`, sucht, sortiert und blättert, und öffnet ein Buch einer Reihe (zum Beispiel Harry Potter). Die Links vorheriges und nächstes führen zu den Nachbarbüchern.

### 2. Haltet das Muster als Skill fest

```text
Schreibe aus dem, was du gerade gebaut hast, einen Skill unter .claude/skills/add-book-feature/SKILL.md. Er soll beschreiben, wie in diesem Projekt ein Buch-Feature gebaut wird: API-Client, Seite, URL-Zustand, Prüfung. Höchstens 8 nummerierte Schritte. Die description beginnt mit den Wörtern, die in einer Anfrage vorkommen würden (Buch, Detailseite, Katalog, Feld) und sagt, wann der Skill geladen wird.
```

Lest die Datei. Claude sieht von jedem Skill zuerst nur die `description`, deshalb entscheidet sie, ob er geladen wird.

### 3. Testet den Skill in einer neuen Session

Startet eine neue Session und bittet um eine kleine Änderung, ohne den Skill zu nennen. Ihr schreibt den Prompt selbst. Er soll eine Buchfunktion betreffen, die der Skill abdeckt. Zum Beispiel:

```text
Zeige auf jeder Buchkarte im Katalog auch den Verlag an.
```

Schaut im Verlauf, ob Claude `add-book-feature` geladen hat. Seht ihr es nicht, fragt Claude: "Welche Skills hast du für diese Aufgabe geladen?" In unserem Lauf hat es den Skill geladen. Wenn nicht, ergänzt in der `description` die Wörter aus eurem Prompt.

### 4. Legt einen Befehl an

```text
Lege unter .claude/skills/new-book-view/SKILL.md einen Befehl /new-book-view an, den nur ich aufrufen kann (disable-model-invocation: true). Er bekommt ein Argument, create oder edit, und baut den Bildschirm nach dem Skill add-book-feature. create: Formular unter /books/new, schickt POST /books, zeigt bei 409 eine klare Meldung, dass die ISBN schon existiert. edit: Formular unter /books/<isbn>/edit mit den Werten des Buchs, schickt PATCH /books/<isbn> ohne id, createdAt, updatedAt. Beide teilen sich ein Formular, nur Aktion und Vorgabewerte unterscheiden sich. Beide Routen sind nur angemeldet erreichbar.
```

### 5. Baut den Create-Bildschirm

Tippt `/new-book-view create`. Das Argument landet im Text des Befehls. Meldet euch danach im Browser an und legt unter http://localhost:3000/books/new ein Buch mit der ISBN 9990000000001 an. Probiert es dann mit der schon vorhandenen ISBN 9780747532699.

### 6. Baut den Edit-Bildschirm

Tippt `/new-book-view edit`. In unserem Lauf nutzte Claude das Formular aus dem ersten Aufruf weiter, statt ein zweites zu bauen. Öffnet http://localhost:3000/books/9990000000001/edit und ändert das Buch.

### 7. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

| | Skill | Befehl | `CLAUDE.md` |
|---|---|---|---|
| Wer startet es | Claude, nach der `description` | ihr, mit `/name` | wird immer geladen |
| Wofür | ein Vorgehen, das öfter vorkommt | ein Auftrag mit Argument | Fakten, die immer gelten |

Beide, Skill und Befehl, sind eine `SKILL.md`. `disable-model-invocation: true` macht aus dem Skill einen Befehl, den nur ihr startet.

**Fertig, wenn** `/books` Suche, Sortierung und Paging zeigt, `/books/<isbn>` durch die Reihe führt, ein neues Buch angemeldet angelegt und bearbeitet werden kann, Claude `add-book-feature` in einer neuen Session selbst geladen hat und alles committet ist.

<details>
<summary>Mehr dazu</summary>

- Ältere Befehle in `.claude/commands/<name>.md` funktionieren weiter und erzeugen dasselbe `/name`.
- Weitere Felder wie `paths` (Skill nur für bestimmte Dateien) und `context: fork` stehen in den Docs: [Skills](https://code.claude.com/docs/en/skills)
- Bücher, die ihr beim Testen angelegt habt, entfernt `curl -X POST http://localhost:4730/dev/reset` wieder.

</details>
