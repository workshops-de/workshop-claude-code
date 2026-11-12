> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

In dieser Aufgabe geht es um **Spec-Driven Development** mit GitHub **Spec Kit**: Ihr schreibt zuerst auf, was gebaut werden soll, und lasst Claude daraus Plan, Aufgabenliste und Code ableiten. Spec Kit bringt dafür Skills mit, also Anweisungen, die ihr als `/speckit-...` in den Chat tippt. Ihr baut einen kleinen Habit-Tracker in einem neuen Ordner `habits`, ohne BookMonkey.

Ihr braucht [uv](https://docs.astral.sh/uv/) (installiert Python-Tools) und Node.js 22 oder neuer für die Tests. Der Habit-Tracker wird später auf http://localhost:3430 ausgeliefert.

### 1. Installiert Spec Kit und legt das Projekt an

Im Terminal (in der Desktop-App öffnet ihr es im Ordner, in dem `habits` entstehen soll):

```bash
uv tool install specify-cli
specify init habits --integration claude
```

Ist `specify` schon installiert, aktualisiert ihr mit `uv tool upgrade specify-cli`. Es entsteht der Ordner `habits` mit `.claude/skills/` (die Skills) und `.specify/` (Vorlagen und Skripte). Öffnet `habits` in der Desktop-App und startet dort eine neue Session.

### 2. Legt die Prinzipien fest

```text
/speckit-constitution Einfach und klein halten, Daten nur lokal im Browser, Tests für die Logik, bedienbar mit der Tastatur.
```

Claude schreibt `.specify/memory/constitution.md`, die **Constitution**. Gegen diese Prinzipien prüft Spec Kit alle späteren Schritte.

### 3. Beschreibt, was ihr wollt

```text
/speckit-specify Ein Habit-Tracker: Ich lege Gewohnheiten an, hake sie jeden Tag ab und sehe, wie viele Tage in Folge ich sie geschafft habe. Eine Seite, keine Anmeldung.
```

In unserem Lauf entstand `specs/001-habit-tracker/spec.md` mit User Stories und Anforderungen, ohne Technik. Lest die Spec und achtet auf den Abschnitt mit den Annahmen, die Claude ohne Rückfrage getroffen hat.

### 4. Wählt die Technik

```text
/speckit-plan Reines HTML, CSS und JavaScript ohne Build-Schritt, Daten in localStorage, Tests mit dem eingebauten Node-Testrunner (node --test). Die Seite wird von einem kleinen Node-Server ohne Abhängigkeiten auf Port 3430 ausgeliefert. In package.json startet npm start den Server und npm test die Tests.
```

Erst jetzt geht es um Technik. Neben `plan.md` entstehen unter anderem `research.md` und `data-model.md`.

### 5. Zerlegt den Plan in Aufgaben

```text
/speckit-tasks
```

Claude schreibt `tasks.md`, eine nummerierte Liste kleiner Aufgaben, gruppiert nach User Story. In unserem Lauf waren es 23.

### 6. Setzt die Aufgaben um

```text
/speckit-implement
```

Claude arbeitet die Liste ab und hakt jede Aufgabe in `tasks.md` ab. In unserem Lauf dauerte das knapp zwei Minuten. Prüft dann selbst: `npm test` (in unserem Lauf 37 Tests grün), `npm start` und http://localhost:3430 im Browser öffnen. Legt eine Gewohnheit an und hakt sie ab.

### 7. Ändert eine Anforderung zuerst in der Spec

Findet etwas, das ihr beim Ausprobieren anders haben wollt, und schreibt es als neue Anforderung in die Spec, ohne den Code anzufassen. Dann lasst ihr Spec Kit die Lücke zum Code finden. Zum Beispiel:

```text
Neue Anforderung: Ich will auch den gestrigen Tag nachträglich abhaken können. Ändere nur die spec.md dieses Features unter specs/, keinen Code.
```

Danach:

```text
/speckit-converge
```

`/speckit-converge` vergleicht Spec und Code und hängt die fehlende Arbeit als neue Aufgaben an `tasks.md` an. In unserem Lauf waren es sechs, der Code blieb unverändert. Mit `/speckit-implement` setzt ihr sie um.

### Was gerade passiert ist

| Schritt | Ergebnis | Inhalt |
|---|---|---|
| constitution | `.specify/memory/constitution.md` | Prinzipien |
| specify | `specs/.../spec.md` | was und warum |
| plan | `plan.md` und weitere | wie |
| tasks | `tasks.md` | Arbeitsschritte |
| implement | Code und Tests | Umsetzung |

Die Spec ist die Quelle der Wahrheit, der Code wird daraus abgeleitet. Eine neue Anforderung ändert deshalb zuerst die Spec. Jeder Schritt erzeugt eine Datei, die ihr lesen und korrigieren könnt, bevor der nächste beginnt.

**Fertig, wenn** `spec.md`, `plan.md` und `tasks.md` existieren, der Habit-Tracker unter http://localhost:3430 läuft und ihr nach einer Änderung in der Spec mit `/speckit-converge` neue Aufgaben bekommen habt.

<details>
<summary>Mehr dazu</summary>

- Optional zwischen den Schritten, laut Docs: `/speckit-clarify` (vor dem Plan, stellt Rückfragen zur Spec), `/speckit-checklist` und `/speckit-analyze` (nach den Tasks, prüft Spec, Plan und Tasks auf Widersprüche). Wir haben sie nicht ausgeführt.
- Spec Kit ändert sich schnell. Dieser Ablauf lief mit `specify-cli` 1.3.3, ältere Versionen haben andere Befehle.
- [Repository](https://github.com/github/spec-kit) · [Quickstart](https://github.github.io/spec-kit/quickstart.html) · [uv installieren](https://docs.astral.sh/uv/)

</details>
