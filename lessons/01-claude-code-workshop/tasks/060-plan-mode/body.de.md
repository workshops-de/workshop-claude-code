In dieser Aufgabe geht es um den **Plan Mode**: Claude schlägt zuerst einen Plan vor und ändert nichts, ihr korrigiert den Plan, und erst dann wird gebaut.

Ihr arbeitet in einem neuen, leeren Ordner `bookmonkey` mit Node.js 26 (zum Beispiel `mkdir bookmonkey && cd bookmonkey && git init`). Öffnet ihn in der Desktop-App und startet dort eine neue Session. Startet in einem Terminal die API mit `npx bookmonkey-api`, sie läuft dann unter http://localhost:4730.

### 1. Lasst Claude einen Plan machen

Stellt den Modus auf **Plan** und schickt:

```text
Plane ein neues Next.js-Projekt mit TypeScript und Tailwind für BookMonkey, einen Buchkatalog. Es soll einen öffentlichen und einen geschützten Bereich geben, getrennt durch Route Groups. Die Startseite zeigt die Titel der ersten fünf Bücher von http://localhost:4730/books?_limit=5. Ändere noch nichts, ich will erst den Plan sehen.
```

Claude liest und prüft, zeigt einen Plan und legt keine Projektdateien an. Schaut in den Ordner: Er ist noch leer.

### 2. Korrigiert den Plan

Lest den Plan genau. In unserem Lauf enthielt er Dinge, die wir nicht wollten: einen `src`-Ordner, eine Umgebungsvariable mit anderem Namen, eine Login-Seite mit Cookie-Prüfung. Die Korrektur legt fest, was spätere Aufgaben brauchen. Bietet die App an, den Plan freizugeben, tut das noch nicht und schreibt eure Änderung ins Eingabefeld. Schickt:

```text
Ändere den Plan: Kein src-Ordner, die Seiten liegen direkt in app/. Die Umgebungsvariable heißt NEXT_PUBLIC_API_URL. Der geschützte Bereich ist vorerst nur eine Seite /library mit einer kurzen Überschrift, ohne Login und ohne Cookie. Ich ergänze die Anmeldung später selbst. Zeig mir den neuen Plan, ändere noch nichts.
```

Claude zeigt einen neuen Plan, der eure Punkte übernimmt. Der Ordner ist weiterhin leer.

### 3. Korrigiert selbst

Findet im neuen Plan etwas, das ihr anders haben wollt, und schreibt die Korrektur selbst. Weil spätere Aufgaben darauf aufbauen, solltet ihr dabei erreichen: Die beiden Route Groups heißen `(public)` und `(app)`, und die Funktion für die API liegt in `lib/api.ts`. Schreibt auch dazu, dass Claude noch nichts ändern soll.

Zum Beispiel:

```text
Die beiden Route Groups sollen (public) und (app) heißen, und die Funktion für die API soll in lib/api.ts liegen. Zeig mir den neuen Plan, ändere noch nichts.
```

### 4. Gebt den Plan frei

Jetzt vertraut ihr dem Plan. Gebt ihn frei, falls die App das anbietet, oder stellt den Modus von Plan auf Auto, damit Claude Dateien ändern darf. Schickt dann:

```text
Der Plan passt. Setze ihn um und prüfe am Ende mit npm run build, dass alles läuft.
```

Die Installation dauert einige Minuten. In unserem Lauf scheiterte der erste Build an der Next.js-Funktion Cache Components, Claude hat das selbst behoben.

### 5. Seht euch das Ergebnis an

```text
Starte den Entwicklungsserver und sag mir die URL.
```

Öffnet die Adresse im Browser: Fünf Buchtitel erscheinen. Unter `/library` seht ihr die Überschrift des geschützten Bereichs.

### 6. Committet, was ihr gelesen habt

```text
Mach den ersten Commit. Lies vorher die Änderungen und schreib eine passende Commit-Nachricht.
```

Prüft in der Commit-Übersicht, dass `.env.local` nicht dabei ist. In unserem Lauf kam eine `.env.example` mit.

### Was gerade passiert ist

Im Plan Mode liest Claude nur und ändert euren Code nicht. Ihr habt den Plan zweimal geändert, bevor die erste Datei existierte. Einen Plan ändert ihr mit einem Satz, ein fertiges Projekt aufzuräumen dauert länger. Merkt euch: **erst Plan prüfen und korrigieren, dann bauen lassen**.

**Fertig, wenn** `/` fünf Buchtitel von der API zeigt, `/library` erreichbar ist und das Projekt committet ist.

<details>
<summary>Mehr dazu</summary>

- Plan Mode: https://code.claude.com/docs/en/permission-modes#analyze-before-you-edit-with-plan-mode
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api
- Route Groups: https://nextjs.org/docs/app/building-your-application/routing/route-groups

</details>
