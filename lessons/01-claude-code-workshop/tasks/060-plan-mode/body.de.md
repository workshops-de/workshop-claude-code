## Überblick

Nutzt den **Plan Mode** als echtes Steuerungswerkzeug und nicht nur als Nur-Lesen-Schalter: Lasst euch
einen Plan erstellen, diskutiert mit ihm, ändert ihn und entscheidet erst dann, wie viel Autonomie
der Agent bei der Ausführung bekommt. Den Plan Mode habt ihr in der Grundlagen-Aufgabe kurz kennengelernt;
hier setzt ihr ihn für eine Änderung ein, bei der es wirklich darauf ankommt.

## Das Feature

Im Plan Mode kann Claude Code lesen und recherchieren, aber keine Dateien ändern und keine
verändernden Befehle ausführen. Das Ergebnis ist ein **Plan**, den ihr prüft, bevor irgendetwas passiert.

- **Aktivieren** mit `Shift+Tab` (so oft drücken, bis die Statuszeile den Plan Mode anzeigt), mit
  `/plan` vor einem einzelnen Prompt oder direkt beim Start: `claude --permission-mode plan`.
- **Den Plan im Gespräch verfeinern**: fragen, warum ein Schritt nötig ist, unerwünschte Schritte
  streichen, fehlende Rahmenbedingungen ergänzen. Ein Plan ist billig zu ändern, ein Scaffold nicht.
- **Den Plan selbst bearbeiten**: Sobald der Plan angezeigt wird, öffnet `Ctrl+G` ihn im
  Standard-Texteditor. Ändern, speichern, und der Agent macht mit eurer Version weiter.
- **Die Ausführung wählen**: Der Bestätigungsdialog bietet **Yes, and use auto mode** (bzw.
  **Yes, auto-accept edits**, wo der Auto Mode nicht verfügbar ist), **Yes, manually approve edits**
  und **No, keep planning**. Wählt passend dazu, wie sehr ihr dem Plan vertraut.

Die Gewohnheit dahinter: Der günstigste Moment, eine falsche Richtung zu korrigieren, ist vor der
ersten Dateiänderung.

## Anwendung auf BookMonkey

> **Repo / Ports:** ein neues, leeres `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!` (wird ab der Subagents-Aufgabe gebraucht)

Im gesamten Workshop baut ihr **BookMonkey**, einen kleinen Buchkatalog. Das Backend gibt es
schon: Die fertige [`bookmonkey-api`](https://github.com/workshops-de/bookmonkey-api) liefert
50 Bücher mit Covern, Reihen-Verknüpfungen und einem Demo-Login. Das Frontend baut ihr jetzt dagegen;
später (in den Aufgaben zu TDD und autonomen Workflows) ersetzt ihr die API durch ein eigenes
Backend, das denselben Vertrag einhält.

Übungsfeld ist hier: aus einem leeren Repository ein lauffähiges Next.js-App-Router-Projekt mit
TypeScript und Tailwind CSS machen, mit einem **öffentlichen Bereich** (Katalog, später Anmeldung)
und einem **geschützten Bereich** (später eure Leseliste), getrennt durch Route Groups, sowie einer
Seite, die die API-Anbindung beweist. Scaffolding ist repetitiv und gut dokumentiert, ideal zum
Delegieren, solange ihr steuert.

## Voraussetzungen

- Node.js 26 (aktuelles LTS). `bookmonkey-api` deklariert `node >=26` in den `engines`.
- Startet die API in einem separaten Terminal und lasst sie laufen: `npx bookmonkey-api`. Sie
  lauscht auf `http://localhost:4730`; die interaktive Doku liegt unter `http://localhost:4730/api`.
- Optionale Skills (nice to have, nicht erforderlich):
  `npx skills add vercel-labs/agent-skills@vercel-react-best-practices -y` und
  `npx skills add anthropics/skills@frontend-design -y`.

## Schritte

1. Legt ein neues, leeres Repository für euer BookMonkey neben dem `bookmonkey-legacy`-Clone an
   (`mkdir bookmonkey && cd bookmonkey && git init`). Startet dort Claude Code im Plan Mode
   (`claude --permission-mode plan`) und
   lasst das Scaffold planen: Stack, Route Groups für öffentliche vs. geschützte Bereiche, Styling,
   die API-Basis-URL als Umgebungsvariable (`NEXT_PUBLIC_API_URL=http://localhost:4730`) und
   eine Startseite, die die Titel der ersten fünf Bücher von `GET /books?_limit=5` auflistet.
   Das Repository ist bis auf `.git` leer, also sollte der Plan **in das aktuelle Verzeichnis**
   scaffolden, mit nicht-interaktiven Flags, zum Beispiel
   `npx create-next-app@latest . --ts --tailwind --eslint --app --no-src-dir --import-alias "@/*" --use-npm --yes`.
   Allein die Installation kann mehrere Minuten dauern.
2. **Hinterfragt den Plan** mindestens zweimal: Wählt **No, keep planning** und stellt jede
   Library infrage, die ihr nicht angefordert habt (Data-Fetching-Library, UI-Kit, State Manager),
   oder lasst den Agenten einen Schritt begründen, bei dem ihr unsicher seid. Beobachtet, wie sich
   der Plan ändert.
3. Sobald der überarbeitete Plan angezeigt wird, drückt `Ctrl+G`, ändert selbst ein Detail (zum
   Beispiel einen Routennamen) und speichert. Prüft, dass der Agent eure Version übernimmt.
4. Bestätigt den Plan und **wählt bewusst** die Ausführungsoption: Auto Mode / auto-accept oder
   Änderungen manuell bestätigen. Beobachtet die Befehle, die er ausführt.
5. **Prüfen**: Startet den Entwicklungsserver und öffnet die App im Browser: Fünf echte Buchtitel
   sollten erscheinen.
6. Prüft die Änderungen und macht euren ersten Commit mit einer Commit-Nachricht, die ihr
   gelesen habt. Committet eine `.env.example` neben der per Git ignorierten `.env.local`: Die
   `.gitignore` der Vorlage ignoriert `.env*`, ergänzt also `!.env.example`.

## Erfolgskriterien

**Feature**

- [ ] Ihr habt eine Session im Plan Mode gestartet und einen Plan erhalten, bevor sich eine Datei geändert hat
- [ ] Der Plan hat sich mindestens einmal geändert, weil ihr widersprochen habt
- [ ] Ihr habt den Plan über `Ctrl+G` im Editor bearbeitet und der Agent hat mit eurer Änderung weitergemacht
- [ ] Ihr könnt erklären, welchen Ausführungsmodus ihr nach der Bestätigung gewählt habt und warum

**App funktioniert weiterhin**

- [ ] `npm run dev` liefert die App aus; eine öffentliche und eine geschützte Route Group werden beide gerendert
- [ ] Die Startseite zeigt fünf Buchtitel, geladen von der laufenden `bookmonkey-api`
- [ ] Die API-Basis-URL kommt aus einer Umgebungsvariable, nicht aus einem hartcodierten String, und
      eine committete `.env.example` dokumentiert sie
- [ ] Type-Check und `npm run build` laufen durch; das Scaffold ist committet

## Referenzen

- Claude Code: Plan mode: https://code.claude.com/docs/en/permission-modes#analyze-before-you-edit-with-plan-mode
- Claude Code: Common workflows: https://code.claude.com/docs/en/common-workflows
- Claude Code: Interactive mode (shortcuts): https://code.claude.com/docs/en/interactive-mode
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api
- Next.js: Route groups: https://nextjs.org/docs/app/building-your-application/routing/route-groups
- Next.js: Environment variables: https://nextjs.org/docs/app/building-your-application/configuring/environment-variables
