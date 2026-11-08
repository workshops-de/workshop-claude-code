## Überblick

Nutzt **Subagents**, um fokussierte Arbeit an einen separaten Kontext zu übergeben: zuerst einen
eingebauten für lautes Erkunden, dann euren eigenen **Security-Reviewer** mit eingeschränkten Tools.
Ihr delegiert die Recherche, behaltet eine schlanke Haupt-Session und verantwortet trotzdem jedes
Finding, auf das ihr reagiert.

## Das Feature

Ein Subagent läuft mit einem **eigenen Kontextfenster**, einem eigenen System-Prompt und optional
einem eingeschränkten Satz an Tools. Die Haupt-Session übergibt ihm eine Aufgabe; er arbeitet
woanders und liefert nur eine Zusammenfassung zurück. Was er unterwegs liest, landet nicht in eurem Kontext.

- **Eingebaute Subagents**: z. B. **Explore**, den Claude für schreibgeschützte
  Codebasis-Recherche nutzt.
- **Eigene Subagents**: Markdown-Dateien in `.claude/agents/` (Projekt, committen) oder
  `~/.claude/agents/` (persönlich). Bittet Claude, einen zu erstellen, oder schreibt die Datei selbst:

  ```markdown
  ---
  name: security-reviewer
  description: Prüft Auth-, Session- und Secret-Handling auf Sicherheitsprobleme. Proaktiv nach Änderungen am Authentifizierungscode einsetzen.
  tools: Read, Grep, Glob
  model: inherit
  ---

  Du bist ein Security-Reviewer. Melde Findings nach Schweregrad mit Datei und Zeile.
  Bearbeite niemals Dateien.
  ```

- **Aufruf**: Claude delegiert automatisch anhand der `description`; um einen bestimmten zu
  erzwingen, erwähnt ihn per @ (`@agent-security-reviewer`) oder startet mit `claude --agent security-reviewer`
  eine ganze Session als dieser Agent.
- **Tool-Einschränkung**: `tools` ist eine Allowlist, `disallowedTools` eine Denylist. Ein Reviewer,
  der nicht schreiben kann, „repariert“ nichts hinter eurem Rücken. Er kann auch kein `curl`
  ausführen: Ohne `Bash` liest er nur Code, Live-Tests passieren also in eurer Haupt-Session.
- **Laden:** Claude Code beobachtet `.claude/agents/` und übernimmt neue oder geänderte Dateien
  innerhalb von Sekunden, aber nur, wenn das Verzeichnis beim Start der Session schon existierte.
  Startet nach der ersten Agent-Datei des Projekts neu (`claude --continue` behält eure Unterhaltung).

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Das Übungsfeld ist die **Anmeldung** für BookMonkey. Die `bookmonkey-api` bietet bereits
`POST /register` und `POST /login`, beide liefern `{ accessToken, user }`; eure Aufgabe ist die
Frontend-Seite: Formulare, das Token sicher speichern, Abmelden und ein Guard für den geschützten
Bereich. Es gibt einen Haken, den es zu finden gilt: **Die API prüft das Token an keinem Endpoint.**
Euer Guard schützt Seiten, nicht Daten. Genau so eine Lücke sollte ein unabhängiger Reviewer
aufdecken, und sie ist der Grund, warum ihr später ein eigenes Backend baut.

## Voraussetzungen

- Die `bookmonkey-api` läuft; Demo-User `admin@bookmonkey.api` / `password1!`.
- Optionaler Skill (nice to have, nicht erforderlich): `vercel-labs/agent-skills@vercel-react-best-practices`.

## Schritte

1. Bittet Claude (erst planen), Registrierung, Anmeldung und Abmeldung gegen die API umzusetzen: Das
   Token landet in einem signierten oder verschlüsselten **http-only Cookie**, der auf dem Server
   gesetzt wird (nicht in `localStorage`), und ein Guard leitet den geschützten Bereich auf die
   Anmeldung um. Testet das Ganze im Browser von Anfang bis Ende.
2. **Erkunden mit einem Subagent**: Stellt eine Rechercheanfrage zu eurem Auth-Flow („Verfolge eine
   Anfrage an eine geschützte Seite: Wo wird das Token geprüft, und von wem?“) und lasst sie an
   Explore delegieren. Führt `/context` davor und danach aus und haltet fest, dass der Haupt-Kontext
   schlank blieb.
3. Erstellt den **`security-reviewer`**-Subagent in `.claude/agents/` mit schreibgeschützten Tools.
   Ist `.claude/agents/` in dieser Session neu, startet mit `claude --continue` neu, damit er geladen
   wird.
4. Testet die API selbst in der Haupt-Session: `curl -i -X DELETE
   http://localhost:4730/books/<isbn>` ohne Token ist ein fairer Test. Ruft dann den Reviewer
   explizit mit `@agent-security-reviewer` auf eurem Auth-Code auf und fügt die Statuszeile des Tests
   in den Prompt ein, damit er das Verhalten der API in sein Review einbeziehen kann.
5. **Bewertet** die Findings selbst (Triage): Behebt, was in eurem Code echt ist, haltet fest, was nur
   das Backend beheben kann (in `docs/backlog.md` o. Ä.), und lehnt ab, was kein Problem ist, mit
   einer Begründung, jeweils für mindestens ein Finding. Führt den Reviewer nach euren Fixes erneut aus.
6. Stellt nach dem Test den Seed wieder her: `curl -X POST http://localhost:4730/dev/reset` (das
   entfernt auch User, die ihr beim Testen registriert habt).

## Erfolgskriterien

**Feature**

- [ ] Ihr habt eine Rechercheanfrage an einen Subagent delegiert und gesehen, dass der Haupt-Kontext schlank blieb
- [ ] Ein eigener `security-reviewer` existiert in `.claude/agents/` mit einer eingeschränkten `tools`-Liste
- [ ] Ihr habt ihn explizit aufgerufen und seine Findings bewertet (mindestens eines behoben, eines
      mit Begründung abgelehnt)

**App funktioniert weiterhin**

- [ ] Registrierung, Anmeldung und Abmeldung funktionieren von Anfang bis Ende; die Session bleibt über Reloads erhalten
- [ ] Das Token liegt in einem http-only Cookie (in Produktion secure), nie in `localStorage`
- [ ] Der Guard leitet jede Seite des geschützten Bereichs auf die Anmeldung um
- [ ] Das nicht erzwungene Token auf API-Seite ist als bekannte Backend-Lücke dokumentiert
- [ ] Type-Check und `npm run build` laufen durch

## Stolperfallen (aktuelles Framework)

- `cookies()` / `headers()` aus `next/headers` sind in aktuellem Next.js **asynchron**: mit `await` aufrufen.
- Ein `redirect()` in einer Server Action funktioniert, indem es **wirft**: nicht in `try/catch` verschlucken.
- Einen Cookie zu setzen funktioniert in Server Actions und Route Handlers, nicht in Server Components.
- Next.js 16 hat `middleware.ts` in **`proxy.ts`** umbenannt. Ihr `matcher` muss jede geschützte
  Route abdecken, auch solche, die ihr in späteren Aufgaben hinzufügt.
- Mit aktivierten Cache Components bricht das direkte Lesen von `cookies()` in einem Layout den Build
  (`Next.js encountered uncached or runtime data during prerendering`). Macht die Prüfung in einer
  kleinen asynchronen Komponente innerhalb von `<Suspense>`.

## Referenzen

- Claude Code: Subagents: https://code.claude.com/docs/en/sub-agents
- Claude Code: Invoke subagents explicitly: https://code.claude.com/docs/en/sub-agents#invoke-subagents-explicitly
- BookMonkey API: Auth: https://github.com/workshops-de/bookmonkey-api#auth
- Next.js: Authentication guide: https://nextjs.org/docs/app/building-your-application/authentication
- OWASP: Session management cheat sheet: https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html
