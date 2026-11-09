## Überblick

Lernt, das **Kontextfenster als wertvollste, begrenzte Ressource** zu behandeln und gezielt zu
verwalten. An einer echten Legacy-Codebasis füllt ihr das Fenster absichtlich, beobachtet, was das
mit den Antworten macht, und kompaktiert oder leert es dann, damit der Agent bei längeren Aufgaben
genau bleibt.

## Das Feature

Die Qualität eines Modells sinkt, wenn sein Kontext sich mit Rauschen, Widersprüchen oder reiner
Länge füllt. Der „Lost in the Middle“-Effekt bedeutet: Informationen mitten in einem langen
Kontext bekommen weniger Aufmerksamkeit, ein größerer Kontext ist also nicht automatisch besser.
Claude Code gibt euch die Hebel dafür:

- **`/context`** zeigt das Fenster als farbiges Raster: System-Prompt, Memory-Dateien, Tools und
  euer Gespräch, dazu Vorschläge, wenn etwas viel Platz belegt.
- **`/compact [instructions]`** fasst das bisherige Gespräch zusammen und macht mit der
  Zusammenfassung weiter. Gebt Fokus-Anweisungen mit, zum Beispiel
  `/compact keep the list of routes and their files`.
- **`/clear`** startet ein neues Gespräch mit leerem Kontext. Nutzt es für Aufgaben, die nichts
  miteinander zu tun haben.
- **`/btw <question>`** stellt eine Zwischenfrage, ohne sie dem Gespräch hinzuzufügen.
- **Delegiert das Lesen.** Ein Subagent (oder der eingebaute Explore-Agent) liest in seinem
  eigenen Kontext und liefert nur das Ergebnis zurück. Subagents lernt ihr in einer späteren
  Aufgabe richtig kennen.

## Anwendung auf BookMonkey Legacy

> **Repo / Ports:** euer `bookmonkey-legacy`-Clone (Node.js 24 oder neuer), API auf
> http://localhost:4780, Web-App auf http://localhost:5180
>
> **Login:** Admin `admin@bookmonkey.example` / `admin2021`

Das Übungsfeld ist euer [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy)-Clone.
Bei Legacy-Code geht der Kontext zuerst aus: eine Route-Datei mit mehr als tausend Zeilen, eine
große Seed-Datei sowie Test- und Server-Logs, die niemand kürzt. Genau das Material, das ein
Fenster füllt, ohne dass es jemand merkt.

## Voraussetzungen

- Der `bookmonkey-legacy`-Clone mit installierten Abhängigkeiten (`npm install`,
  `npm run db:reset`)

## Schritte

1. Startet eine frische Session im Manual oder Plan Mode (`claude --permission-mode default` oder
   `claude --permission-mode plan`), damit das Repository sauber bleibt, und führt `/context` aus.
   Notiert die Ausgangsbasis: Wie viel belegen System-Prompt, Tools und eure `CLAUDE.md`, bevor ihr
   etwas getippt habt?
2. Stellt eine präzise Frage, die ihr später prüfen könnt, zum Beispiel „Welche Datei und
   Funktion verlängern eine Ausleihe, und wie lauten die Verlängerungsregeln?“. Schreibt die
   Antwort auf.
3. **Verschmutzt** die Session jetzt absichtlich und prüft nach jedem Schritt `/context`:
   - Claude soll `api/routes.js` komplett lesen und jeden Abschnitt zusammenfassen
   - Claude soll `api/seed/books.json` und dann viele weitere Dateien unter `api/` mit dem Read-Tool
     lesen
   - startet `npm run dev:api`, klickt durch ein paar Seiten der Web-App (oder führt `npm test`
     aus) und fügt einen langen Ausschnitt des API-Logs in den Chat ein

   Große Bash-Ausgaben (etwa `git log -p`) werden auf eine Vorschau gekürzt: Das Tool schützt euren
   Kontext.
4. Stellt die Frage aus Schritt 2 noch einmal, dazu eine zu einem Detail aus der allerersten Datei,
   die Claude gelesen hat. Notiert Abweichungen, vage Antworten und vergessene Details.
5. **Kompaktiert** mit `/compact` und Fokus-Anweisungen eurer Wahl. Stellt beide Fragen erneut und
   vergleicht vorher und nachher. Was hat die Zusammenfassung behalten, was hat sie verworfen?
6. Startet eine wirklich **neue, unabhängige Aufgabe** (zum Beispiel „erkläre das Routing der
   Web-App“) mit `/clear`, statt die verschmutzte Session fortzusetzen. Vergleicht `/context` mit
   eurer Ausgangsbasis.
7. Macht das aufwendige Lesen auf die schlanke Art noch einmal: Lasst einen Subagent „jede
   Migrationsdatei und die Tabellen, die sie anlegt, auflisten, eine Zeile pro Datei“, und
   vergleicht, was in eurem Haupt-Kontext landet.
8. Formuliert einen früheren Prompt so um, dass die wichtigste Randbedingung ganz am Anfang (oder
   Ende) steht, und beobachtet, ob das Ergebnis besser wird.

## Erfolgskriterien

**Feature**

- [ ] Ihr habt eine Ausgangsbasis mit `/context` festgehalten und beobachtet, wie sie in der
      verschmutzten Session wächst
- [ ] Ihr habt eine Session mit Fokus-Anweisungen kompaktiert und mit dem kleineren Kontext
      weitergemacht
- [ ] Ihr habt für eine unabhängige Aufgabe mit `/clear` einen sauberen Kontext gestartet
- [ ] Ihr könnt mindestens zwei Fehlerarten des Kontexts nennen, die ihr ausgelöst habt, und die
      Gewohnheit, die jede behoben hat

**Repository weiterhin sauber**

- [ ] `git status` in `bookmonkey-legacy` zeigt keine Änderungen an getrackten Dateien

## Referenzen

- Claude Code: Commands (`/context`, `/compact`, `/clear`, `/btw`): https://code.claude.com/docs/en/commands
- Claude Code: Costs and context usage: https://code.claude.com/docs/en/costs
- Claude Code: Best practices (manage context): https://code.claude.com/docs/en/best-practices
- Claude Code: Subagents: https://code.claude.com/docs/en/sub-agents
- "Lost in the Middle" (Liu et al., 2023): https://cs.stanford.edu/~nfliu/papers/lost-in-the-middle.arxiv2023.pdf
