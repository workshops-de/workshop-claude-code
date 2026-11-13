> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

---

Euer Team übernimmt am Montag `bookmonkey-legacy`. Nächste Woche fängt eine neue Kollegin an, und alle arbeiten mit Claude Code. Ihr habt nach dem Klonen etwa 35 Minuten, um das Repo so vorzubereiten, dass Claude darin von der ersten Session an guten Code schreibt und nichts kaputt macht.

Ihr nutzt dafür alles aus dieser Woche. Es gibt keine Musterlösung. Ihr entscheidet als Gruppe, was ihr baut, was ihr bewusst weglasst, und warum.

### 1. Bildet Gruppen und klont frisch

Arbeitet zu dritt oder zu viert an einem Rechner. Eine Person tippt, die anderen steuern und prüfen mit den Fragen aus „Habt ihr an alles gedacht?“. Wechselt nach jedem Baustein.

Klont das Repo in einen neuen Ordner, damit eure Dateien aus den früheren Aufgaben nicht mitkommen. Ihr braucht Node.js 24 oder neuer (`node -v`):

```bash
git clone https://github.com/andrekovac/bookmonkey-legacy.git bookmonkey-altbau && cd bookmonkey-altbau && npm install && npm run db:reset
```

### 2. Lasst Claude gründlich erkunden (7 min)

Startet eine Session im Plan Mode und fragt wie bei einer Übergabe unter Kollegen:

```text
Wir übernehmen dieses Repo und wollen, dass du hier ab Montag sicher arbeiten kannst. Erkunde es gründlich: wie man es startet und testet, wie die Daten fließen, wo es riskant ist. Belege jede Aussage mit Datei und Zeile, und ändere noch nichts.
```

Wenn Claude fragt, ob es den Plan umsetzen soll, lehnt ab. In diesem Schritt wird nur erkundet. Lest das Ergebnis gemeinsam und prüft mindestens zwei Aussagen selbst nach.

### 3. Entscheidet, was wohin gehört (3 min)

Sammelt auf Papier oder im Chat, was Claude in diesem Repo wissen oder einhalten muss. Ordnet jeden Punkt einem Ort zu:

| Ort | Wofür |
| --- | --- |
| `CLAUDE.md` | gilt immer, kurz, Claude kann es nicht selbst ablesen |
| Rule in `.claude/rules/` | ein Thema, eventuell nur für bestimmte Pfade |
| Skill | ein Ablauf, der im Team immer wieder vorkommt |
| Hook oder Deny-Regel | darf nie passieren, egal was im Prompt steht |
| nirgends | Claude findet es selbst im Code |

### Habt ihr an alles gedacht?

Nehmt euch pro Baustein ein, zwei Fragen vor. Wer gerade nicht tippt, stellt eine davon der Gruppe, bevor ihr den Baustein committet.

<details>
<summary>CLAUDE.md und Kontext</summary>

- Woher wisst ihr, dass jeder Befehl in eurer `CLAUDE.md` funktioniert? Habt ihr ihn selbst laufen sehen?
- Was würde Claude ohne diese Datei falsch machen? Steht nur das drin?
- Welcher Quelle im Repo würde Claude glauben, ohne sie zu prüfen? Habt ihr eine davon gegengeprüft?
- Läuft das Repo bei der neuen Kollegin mit ihrer Node-Version? Woran merkt sie es, wenn nicht?
- Wie viel Kontext ist schon belegt, bevor ihr den ersten Prompt schreibt?

</details>

<details>
<summary>Rules, Skills und Plan Mode</summary>

- Welche Korrektur müsstet ihr Claude in dieser Woche zum zweiten Mal sagen?
- Widerspricht eine Rule eurer `CLAUDE.md`? Was macht Claude dann, und wie verhindert ihr den Widerspruch?
- Welcher Ablauf kommt in diesem Team immer wieder vor, mit denselben Schritten?
- Wann soll Claude euren Skill von selbst nehmen, und wann gerade nicht? Steht das in der Beschreibung?
- Bei welchen Aufgaben soll Claude in diesem Repo erst planen, bevor es etwas ändert? Wo steht das?

</details>

<details>
<summary>Hooks und Berechtigungen</summary>

- Was darf in diesem Repo nie passieren, egal was im Prompt steht?
- Gibt es Dateien, die Claude gar nicht lesen soll? Wie stellt ihr das sicher?
- Bei welchem Befehl wollt ihr nie wieder auf „Erlauben“ klicken? Und welcher darf nie ohne Rückfrage laufen?
- Wie zeigt ihr, dass euer Hook wirklich blockiert, und nicht nur, dass es ihn gibt?
- Was ist, wenn Claude dasselbe mit einem anderen Befehl erreicht?

</details>

<details>
<summary>Tests und Qualität</summary>

- Woran merkt Claude selbst, dass es etwas kaputt gemacht hat?
- Woher wisst ihr, wie der Stand der Tests vor eurer ersten Änderung ist?
- Was ist, wenn Claude Code ändert, für den es noch keinen Test gibt?
- Wer liest Claudes Diff mit frischem Blick, ohne den Verlauf dieser Session zu kennen?

</details>

<details>
<summary>Team und Alltag</summary>

- Was gehört in `.claude/settings.json`, was in `.claude/settings.local.json` oder eure persönliche Konfiguration?
- Die neue Kollegin klont das Repo morgen: Läuft euer Hook bei ihr ohne Erklärung? Braucht er ein Tool, das nur ihr installiert habt?
- Holt ihr Tickets oder Daten bisher von Hand aus Jira oder dem Browser? Gehört dafür ein MCP-Server ins Repo?
- Wie merkt ihr in drei Monaten, dass eure `CLAUDE.md` nicht mehr stimmt?

</details>

### 4. Baut euer Setup (20 min)

Baut zuerst den Baustein, der am meisten bringt, und prüft ihn. Ziel sind eine `CLAUDE.md` und ein Baustein, der etwas durchsetzt (Hook oder Deny-Regel). Rule und Skill baut ihr, wenn noch Zeit ist. Was fehlt, kommt auf eure Liste „bewusst weggelassen“.

Sagt Claude bei jedem Baustein, was ihr erreichen wollt und warum, und lasst es den Baustein danach selbst vorführen. Zum Beispiel:

```text
Neue Kolleginnen sollen das Projekt ohne Nachfragen starten und testen können. Schreib eine CLAUDE.md mit nur dem, was du aus dem Code nicht ableiten könntest, höchstens 30 Zeilen. Führe jeden Befehl darin einmal aus und zeig mir die Ausgabe.
```

<details>
<summary>🔑 Fachbegriffe zum Nachsteuern</summary>

- **`paths`** im Frontmatter einer Rule: Die Rule lädt nur bei passenden Dateien.
- **`description`** eines Skills: Danach entscheidet Claude, ob es den Skill von selbst nimmt.
- **PreToolUse** mit Matcher **`Bash`** oder **`Edit|Write`**: Der Hook läuft vor dem Werkzeug. **`exit 2`** blockiert, `exit 1` zeigt einen Fehler, blockiert aber nicht.
- **`permissions.deny`** und **`permissions.allow`** in `.claude/settings.json`: Regeln ohne eigenes Skript.
- **`/memory`** und **`/context`**: zeigen, was geladen ist und wie viel Platz es braucht.

</details>

Committet am Ende alles, was ins Repo gehört.

### 5. Macht die Probe (5 min)

Gebt Claude in einer neuen Session ein echtes Ticket, zum Beispiel BM-412 aus Aufgabe 190 („Nächster Band“ führt ins Nichts). Brecht ab, sobald ihr gesehen habt, ob eure Bausteine greifen: Liest Claude eure Dateien? Greift die Rule? Blockiert der Hook? Fertig werden muss das Ticket nicht. Notiert, was nicht so lief wie gedacht.

### 6. Stellt vor (je Gruppe 3 min)

Bevor ihr vorstellt, gibt euch eine andere Gruppe einen einzigen Prompt, der euren Hook oder eure Deny-Regel umgehen soll. Hält der Baustein, gibt es Applaus. Wenn nicht, zeigt ihr, warum.

Zeigt danach drei Dinge:

1. den Baustein, auf den ihr am meisten stolz seid, mit dem Beweis, dass er wirkt,
2. etwas, das ihr bewusst weggelassen habt, und warum,
3. was bei der Probe anders lief als gedacht.

Jede Gruppe notiert sich eine Idee der anderen, die sie am Montag in ihr echtes Repo übernimmt.

### Fertig, wenn

- eine geprüfte `CLAUDE.md` und ein geprüfter Hook oder eine Deny-Regel in eurem Clone committet sind,
- ihr in einer neuen Session gesehen habt, dass beide wirken,
- `npm test` in eurem Clone weiter grün läuft,
- ihr sagen könnt, was ihr bewusst weggelassen habt und warum.

<details>
<summary>Mehr dazu</summary>

- Die Aufgaben, auf denen das aufbaut: 030 (Berechtigungen), 040 (CLAUDE.md), 050 (Kontext), 060 (Plan Mode), 070 (Rules), 090 (Subagents), 100 (Skills), 110 (MCP), 120 (Hooks), 200 (Tests), 220 (Review).
- Docs: [Memory](https://code.claude.com/docs/en/memory) · [Skills](https://code.claude.com/docs/en/skills) · [Hooks](https://code.claude.com/docs/en/hooks) · [Settings](https://code.claude.com/docs/en/settings) · [Best practices](https://code.claude.com/docs/en/best-practices)

</details>
