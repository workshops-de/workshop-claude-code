## Überblick

Setzt **Skills** ein: Findet und installiert einen fertigen Skill für eine Library, die sich schnell
ändert, beobachtet, wie Claude Code ihn von allein aufgreift, und vergleicht das mit dem expliziten
Aufruf. Ihr seht, warum Skills das richtige Zuhause für prozedurales, aktuelles Know-how sind, das
nicht die ganze Zeit im Kontext liegen soll.

## Das Feature

Ein Skill ist ein Ordner mit einer `SKILL.md` (plus optionalen Hilfsdateien). Nur sein **Name und
seine Beschreibung** liegen im Kontext; die vollständigen Anweisungen werden geladen, wenn die
Aufgabe passt oder wenn ihr ihn aufruft: das ist _Progressive Disclosure_.

- **Wo Skills liegen:** Projekt-Skills in `.claude/skills/<name>/SKILL.md` (committet sie für euer
  Team), persönliche Skills in `~/.claude/skills/<name>/SKILL.md`.
- **Skills von Dritten finden und installieren:** `npx skills find <thema>` durchsucht den
  Community-Katalog; `npx skills add <owner>/<repo>@<skill> -y` installiert einen. Schaut euch an,
  was auf der Platte landet, bevor ihr ihm vertraut.
- **Sehen, was verfügbar ist:** `/skills` listet die Skills der aktuellen Session. Claude Code
  übernimmt Änderungen an Skills live, aber nur in Skill-Verzeichnissen, die beim Start der Session
  schon existierten: Führt nach dem ersten Skill des Projekts `/reload-skills` aus (oder startet neu).
- **Zwei Wege, wie ein Skill läuft:** Claude ruft ihn automatisch auf, wenn euer Prompt zu seiner
  Beschreibung passt, oder ihr ruft ihn direkt mit `/skill-name` auf. Das Transcript zeigt, wann ein
  Skill geladen wurde. Ein Skill mit `user-invocable: false` im Frontmatter ist im `/`-Menü
  verborgen, und `/name` zu tippen führt ihn nicht aus; ihr ruft ihn explizit auf, indem ihr Claude
  bittet, ihn beim Namen zu verwenden.

Skills vs. Memory: `CLAUDE.md` und Regeln sind immer (oder pfadbezogen) geladene Fakten; Skills sind
Abläufe, die bei Bedarf geladen werden.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Das Übungsfeld ist die **Katalogseite** von BookMonkey: ein Raster aus Buchkarten (Cover, Titel,
Autor, Preis mit Währung), das auf eine Detailseite verlinkt, gebaut mit **shadcn/ui** auf eurem
Tailwind-Scaffold. Die shadcn-CLI ist interaktiv und ihre Flags ändern sich häufig: genau die Art
schnelllebigen Wissens, bei der ein gepflegter Skill die Trainingsdaten des Modells schlägt. Die
Daten kommen weiterhin von der laufenden `bookmonkey-api`; eure API-Client-Regel aus der vorherigen
Aufgabe gilt.

## Voraussetzungen

- Die `bookmonkey-api` läuft auf `http://localhost:4730`.
- Optionale Skills (nice to have, nicht erforderlich): `vercel-labs/agent-skills@vercel-react-best-practices`,
  `anthropics/skills@frontend-design`.

## Schritte

1. Führt `npx skills find shadcn` aus und vergleicht die Ergebnisse: Wer veröffentlicht den jeweiligen
   Skill, wie viele Installationen hat er, was verspricht er? Installiert den offiziellen:
   `npx skills add shadcn-ui/ui@shadcn -y`.
   Prüft, was gelandet ist: die Dateien in `.agents/skills/shadcn/`, ein Symlink `.claude/skills/shadcn`
   und eine `skills-lock.json`. Committet alle drei zusammen.
2. Öffnet die installierte `SKILL.md` und lest ihr Frontmatter: die Beschreibung und
   `user-invocable: false`. Führt `/reload-skills` aus (oder startet eine neue Session), dann
   `/skills`, und prüft, dass er aufgelistet ist.
3. Bittet den Agenten, ohne den Skill zu erwähnen, **shadcn/ui** im Projekt **einzurichten** und die
   Komponenten hinzuzufügen, die eine Buchkarte braucht. Beobachtet das Transcript: Hat er den Skill
   von allein geladen?
4. Lasst euch die **Katalogseite** unter `/books` bauen: eine Karte pro Buch von `GET /books` mit Cover,
   Titel, Autor und formatiertem Preis; jede Karte verlinkt auf `/books/<isbn>`.
5. Ruft den Skill für eine Folgeaufgabe **explizit** auf. Der shadcn-Skill ist
   `user-invocable: false`, also funktioniert `/shadcn` nicht: Nennt ihn stattdessen im Prompt, zum
   Beispiel „Nutze den shadcn-Skill, um dem Katalog einen Skeleton-Ladezustand und einen leeren
   Zustand hinzuzufügen“. Vergleicht, wie sich das Ergebnis vom Lauf ohne Anleitung unterscheidet.
6. Vergleicht: Was wusste der Skill, das der Agent allein wahrscheinlich falsch gemacht hätte?
   Haltet die Antwort in einer Zeile eurer `CLAUDE.md` fest.

## Erfolgskriterien

**Feature**

- [ ] Ihr habt den Skill-Katalog durchsucht, bewusst einen Skill gewählt, und er erscheint in `/skills`
- [ ] Ihr habt mindestens einen automatischen Skill-Aufruf beobachtet und den Skill explizit beim Namen aufgerufen
- [ ] Ihr könnt Progressive Disclosure erklären und warum dieses Wissen in einen Skill gehört und nicht in
      die `CLAUDE.md`

**App funktioniert weiterhin**

- [ ] Die Katalogseite rendert die Bücher aus der API mit Covern, Titeln, Autoren und Preisen
- [ ] Karten-Links nutzen die ISBN (`/books/<isbn>`), nicht die `id`
- [ ] Type-Check und `npm run build` laufen durch

## Referenzen

- Claude Code: Skills: https://code.claude.com/docs/en/skills
- Skills catalogue: https://skills.sh
- Agent skills (open format): https://agentskills.io
- shadcn/ui: Installation (Next.js): https://ui.shadcn.com/docs/installation/next
- BookMonkey API: https://github.com/workshops-de/bookmonkey-api
