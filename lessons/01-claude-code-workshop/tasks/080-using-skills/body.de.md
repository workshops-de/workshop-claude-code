In dieser Aufgabe geht es um **Skills**: fertige Anleitungen für Claude, zum Beispiel für eine Library, die sich schnell ändert. Ihr installiert einen Skill für **shadcn/ui** und baut damit die Katalogseite von BookMonkey.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26. Die `bookmonkey-api` muss auf http://localhost:4730 laufen.

### 1. Installiert den shadcn-Skill

Öffnet in der Desktop-App das Terminal und führt im Projekt aus:

```text
npx skills add shadcn-ui/ui@shadcn -y
```

Die Ausgabe zeigt Sicherheitsbewertungen. Im Projekt liegen danach der Ordner `.agents/skills/shadcn`, ein Symlink `.claude/skills/shadcn` und die Datei `skills-lock.json`. Öffnet die `SKILL.md` und lest die ersten Zeilen: Dort steht, wofür der Skill gedacht ist.

### 2. Baut die Katalogseite, ohne den Skill zu erwähnen

Startet eine neue Session, damit Claude den Skill kennt, und gebt diesen Prompt:

```text
Richte shadcn/ui in diesem Projekt ein und baue unter /books eine Katalogseite: eine Karte pro Buch von GET /books mit Cover, Titel, Autor und Preis. Jede Karte verlinkt auf /books/<isbn>.
```

Schaut im Verlauf, ob Claude den Skill geladen hat. In unserem Lauf war `Skill shadcn` der erste Aufruf, noch vor dem Lesen des Projekts. Die Links auf `/books/<isbn>` führen noch ins Leere, die Detailseite baut ihr in einer späteren Aufgabe.

### 3. Fragt, was der Skill bewirkt hat

```text
Nenne drei Stellen in der Katalogseite, die du wegen des Skills so gebaut hast. Ändere nichts.
```

In unserem Lauf nannte Claude die Regeln aus dem Skill: vollständiger Aufbau der Karte (`CardHeader`, `CardDescription`, `CardFooter`), `Badge` für den Preis, nur semantische Farben. Ohne Skill lief dieselbe Aufgabe bei uns auch durch, aber die Karte war anders aufgebaut: Das Cover stand in `CardContent` und der Preis im `CardHeader`.

### 4. Ruft den Skill ausdrücklich auf

```text
Nutze den shadcn-Skill, um dem Katalog einen Skeleton-Ladezustand und einen leeren Zustand hinzuzufügen.
```

Claude lädt den Skill wieder, holt sich `skeleton` und `empty` mit der shadcn-CLI und baut beide Zustände mit diesen Komponenten, nicht mit selbstgebauten `div`s. In der `SKILL.md` steht `user-invocable: false`: Ihr nennt den Skill deshalb im Prompt, statt `/shadcn` zu tippen.

### 5. Gebt selbst eine Aufgabe mit dem Skill

Formuliert einen eigenen Prompt, der den Skill nennt und die Seite um ein Suchfeld erweitert, das die Bücher nach Titel filtert. Ein Satz reicht, zum Beispiel: „Nutze den shadcn-Skill und baue über dem Raster ein Suchfeld ein, das die Bücher nach Titel filtert.“ Prüft die Seite danach im Browser.

### 6. Was gerade passiert ist

Ein Skill ist ein Ordner mit einer `SKILL.md`. Claude sieht zuerst nur **Name und Beschreibung**. Passt eure Aufgabe zur Beschreibung, lädt Claude die ganze Anleitung. So bleibt der Kontext schlank.

| | Skill | `CLAUDE.md` und Regeln |
| --- | --- | --- |
| Inhalt | Ablauf, der zu einer Aufgabe passt | Fakten, die immer gelten |
| Geladen | bei Bedarf | immer oder pfadbezogen |

Gut für einen Skill ist Wissen, das sich schnell ändert, wie die shadcn-CLI. Ein Skill ist Text, dem Claude folgt. Lest ihn deshalb vor der Installation und achtet darauf, wer ihn veröffentlicht.

**Fertig, wenn** `/books` die Bücher als Karten mit Cover, Titel, Autor und Preis zeigt, der Skill in `.claude/skills/shadcn` liegt und ihr in zwei Läufen gesehen habt, dass Claude ihn lädt.

<details>
<summary>Mehr dazu</summary>

Skills finden: `npx skills find <thema>` oder https://skills.sh. Den Ordner `.agents/skills/` und `skills-lock.json` solltet ihr mit committen, damit euer Team denselben Skill hat. In unseren Läufen hat Claude den Skill ohne Hinweis geladen, das kann bei anderen Formulierungen anders sein.

- [Claude Code: Skills](https://code.claude.com/docs/en/skills)
- [shadcn/ui: Installation für Next.js](https://ui.shadcn.com/docs/installation/next)

</details>
