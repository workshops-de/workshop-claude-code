## Überblick

Macht Qualität und Sicherheit mit Hooks **deterministisch**: Befehle, die Claude Code bei
Lifecycle-Events ausführt, jedes Mal, unabhängig davon, was das Modell entscheidet. Ihr richtet
zuerst einen Format-/Typecheck-Hook und einen Secrets-Guard ein und baut dann, während beide aktiv sind, das
vielschichtigste Feature der App.

## Das Feature

Hooks werden in den Settings konfiguriert (`.claude/settings.json` für das Projekt, committet sie) und
feuern bei Events wie `PreToolUse` (bevor ein Tool läuft, kann blockieren), `PostToolUse` (nachdem
es gelaufen ist), `Stop` oder `SessionStart`.

- **Matcher** wählen die Tools aus, für die ein Hook gilt, z. B. `"Edit|Write"`.
- **Eingabe** kommt als JSON über stdin; die bearbeitete Datei steht in `.tool_input.file_path`:

  ```json
  {
    "hooks": {
      "PostToolUse": [
        {
          "matcher": "Edit|Write",
          "hooks": [
            {
              "type": "command",
              "command": "jq -r '.tool_input.file_path' | xargs npx --no-install prettier --write --ignore-unknown"
            }
          ]
        }
      ]
    }
  }
  ```

- **Blockieren**: In einem `PreToolUse`-Hook blockiert `exit 2` den Tool-Aufruf, und euer stderr
  wird Claude als Begründung gezeigt. Vorsicht: `exit 1` blockiert **nicht**, es zählt als
  nicht blockierender Fehler.
- **Feedback:** Ein `PostToolUse`-Hook kann die Änderung nicht rückgängig machen, aber bei `exit 2`
  sieht Claude seinen stderr und reagiert auf die Fehler. Seine Klartext-Ausgabe bei `exit 0`
  erreicht Claude nicht (bei `SessionStart` und `UserPromptSubmit` erreicht stdout Claude schon).
- **Skripte**: Längere Logik gehört nach `.claude/hooks/*.sh` (ausführbar) und wird mit
  `"${CLAUDE_PROJECT_DIR}/.claude/hooks/guard.sh"` referenziert.
- **Prüfen**: `/hooks` zeigt jeden konfigurierten Hook, seinen Matcher und aus welcher
  Settings-Datei er stammt.

Memory berät, Hooks erzwingen.

## Anwendung auf BookMonkey

> **Repo / Ports:** euer `bookmonkey`-Repository (Node.js 26), Next.js-App auf
> http://localhost:3000, `npx bookmonkey-api` auf http://localhost:4730
>
> **Login:** Demo-User `admin@bookmonkey.api` / `password1!`

Das Übungsfeld ist die **Leseliste** von BookMonkey: Ein angemeldeter User setzt ein Buch auf seine
Liste (_want to read_), beginnt es (_reading_) und schließt es ab (_finished_), und kann ein
abgeschlossenes Buch erneut beginnen oder jederzeit entfernen. Mehr ist nicht erlaubt: kein Sprung
von _want to read_ direkt zu _finished_. Die `bookmonkey-api` hat dafür keinen Endpoint, deshalb
liegt die Liste vorerst im Browser (pro User, in `localStorage`); euer eigenes Backend übernimmt
sie später. Eine kleine State Machine, die ein reines Domain-Modul, einen Client-Store, die
Detailseite, eine Listenseite und den Header gleichzeitig berührt: genau der Fall, in dem ein Hook,
der jede Änderung formatiert und typprüft, den Agenten auf Kurs hält.

## Voraussetzungen

- `jq` installiert (liest die Hook-Eingabe).
- Unter Windows: Hook-Skripte unter Git Bash ausführen und `jq` mit `winget install jqlang.jq` installieren.
- Prettier im Projekt: `npm i -D prettier` (`create-next-app` fügt es nicht hinzu). Legt eine
  kleine `.prettierrc` an, die zu eurem aktuellen Stil passt, sonst formatiert der erste Hook-Lauf
  Code um, den ihr nicht angefasst habt.
- Optionaler Skill (nice to have, nicht erforderlich): `vercel-labs/agent-skills@vercel-react-best-practices`

## Schritte

1. Fügt einen **`PostToolUse`**-Hook für `Edit|Write` hinzu, der die geänderte Datei formatiert und
   einen schnellen Typecheck ausführt, als Skript in `.claude/hooks/`. `tsc --noEmit` prüft das
   ganze Projekt, nicht eine einzelne Datei (bei dieser Größe in Ordnung). Schlägt er fehl, gebt
   die Fehler auf stderr aus und nutzt `exit 2`, sonst sieht Claude sie nie. Macht eine Änderung
   mit einem absichtlichen Typfehler und prüft, dass Claude reagiert.
2. Fügt ein **`PreToolUse`**-Guard-Skript hinzu, das Lese- und Schreibzugriffe auf `.env*`-Dateien
   und Schlüsselmaterial mit `exit 2` blockiert (`.env.example` lasst ihr durch). Prüft den
   Dateipfad (`.tool_input.file_path`), nicht irgendeinen Text: Ein Guard, der zusätzlich den
   `Bash`-Befehlstext durchsucht, blockiert harmlose Befehle, die `.env.local` nur erwähnen, etwa
   eine Commit-Message. Bittet den Agenten, eure `.env.local` zu lesen, und prüft, dass er mit
   eurer Meldung blockiert wird. Der Guard sieht nur Datei-Tools: `cat .env.local` über Bash lief
   im Test trotzdem. Eine Deny-Regel `Read(./.env*)` erfasst auch Befehle wie `cat`.
3. Prüft beide in `/hooks`.
4. Nennt dem Agenten bei aktiven Hooks die **Übergänge** (hinzufügen → _want to read_; beginnen →
   _reading_; abschließen → _finished_; erneut beginnen → _reading_; aus jedem Zustand entfernen)
   und lasst ihn sie (und die unzulässigen) vor dem Coden wiederholen.
5. Lasst ihn die State Machine als **reine Funktion** (`transition(state, action)`) umsetzen, die
   unzulässige Übergänge ablehnt, dazu einen Store pro User darüber, Leselisten-Buttons auf der
   Detailseite, eine Leselisten-Seite im authentifizierten Bereich, nach Zustand gruppiert, und
   einen Zähler im Header. Achtet darauf, wann der Typecheck-Hook den Agenten mitten in der
   Aufgabe zurückpfeift.
6. Prüft mit zwei Accounts im selben Browser (registriert einen zweiten): Jeder sieht nur seine
   eigene Liste, und unzulässige Übergänge sind über die UI nicht möglich.

## Erfolgskriterien

**Feature**

- [ ] Ein Post-Edit-Hook formatiert und typprüft automatisch, und ihr habt gesehen, wie er beim
      Bauen feuert
- [ ] Ein Guard-Hook blockiert den Zugriff auf mindestens einen sensiblen Pfad mit `exit 2`
- [ ] Beide Hooks erscheinen in `/hooks` aus euren Projekt-Settings
- [ ] Ihr könnt erklären, warum diese in Hooks gehören und nicht in die `CLAUDE.md`

**App funktioniert weiterhin**

- [ ] Hinzufügen, Beginnen, Abschließen, erneut Beginnen und Entfernen funktionieren; der
      unzulässige Sprung zu _finished_ wird von der Domain-Funktion abgelehnt, nicht nur in der UI
      versteckt
- [ ] Zwei Accounts im selben Browser sehen getrennte Leselisten; die Listen überstehen ein Neuladen
- [ ] Die Leselisten-Seite gruppiert Bücher nach Zustand und ist nur erreichbar, wenn man
      angemeldet ist
- [ ] `npm run build` läuft durch

## Referenzen

- Claude Code: Hooks reference: https://code.claude.com/docs/en/hooks
- Claude Code: Hooks guide: https://code.claude.com/docs/en/hooks-guide
- Claude Code: Settings: https://code.claude.com/docs/en/settings
- MDN: Window.localStorage: https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
