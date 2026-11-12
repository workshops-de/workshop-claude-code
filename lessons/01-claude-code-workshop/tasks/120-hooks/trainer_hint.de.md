## Lernziele

- **Feature:** Hook-Events und Matcher, JSON-Eingabe über stdin, Blockieren mit `exit 2`,
  Projekt-Hooks in `.claude/settings.json`, `/hooks`.
- **Konzepte:** deterministische Leitplanken vs. beratendes Memory; Defense in Depth.
- **Übungsfeld:** die BookMonkey-Leselisten-State-Machine als reine Domain-Funktion mit einem
  Client-Store pro User.
- **Takeaways:** Wenn es immer passieren muss, macht einen Hook daraus – keine Anweisung.

## Hinweise zur Durchführung

- Knüpft an die `CLAUDE.md`-Aufgabe an: Memory berät, Hooks erzwingen – den Kontrast ausdrücklich
  aufzeigen.
- In die Falle `exit 1` vs. `exit 2` tappen die meisten bei ihrem ersten Guard; sie ruhig
  hineinlaufen lassen und dann auf den Tipp verweisen.
- Auf langsame Hooks achten (komplette Test-Suite pro Änderung) – zurück zu schnellen, gezielten
  Befehlen lenken.
- Der Aha-Moment ist der Typecheck-Hook, der mitten im Feature zurückpfeift; jemanden bitten, ihn
  zu zeigen.
- `localStorage` ist bewusst eine Übergangslösung, weil die API keinen Leselisten-Endpoint hat.
  Fragt jemand „ist das nicht unsicher / nicht geräteübergreifend?“: Ja, und genau das kann das
  eigene Backend in den Aufgaben 200/230 lösen. Die reine `transition`-Funktion behalten: Sie zieht
  unverändert ins Backend um.
- Hydration-Mismatches sind häufig, wenn der Header-Zähler `localStorage` während des Renderns
  liest – ein gutes Debugging-Beispiel, falls es auftritt.
- Der Typecheck-Hook läuft nach jeder einzelnen Änderung. Bei einer Änderung über mehrere Edits
  kann er Fehler wie `Cannot find name ...` melden, die der nächste Edit (oft der Import) behebt.
  Das ist erwartbar; der Agent macht meist einfach weiter.
- `Edit|Write` erfasst keine Dateien, die der Agent über `Bash` schreibt (zum Beispiel per
  Heredoc). Darauf hinweisen, wenn sich jemand wundert, warum der Hook still blieb.
- „Pro User“ braucht auf dem Client einen User-Schlüssel, aber das Session-Cookie ist http-only.
  Rechnet damit, dass der Agent die E-Mail oder ID des angemeldeten Users vom Server in den
  Client-Store reicht.
- Bonus `SessionStart`-Hook (Idee aus dem Kurs): Hängt die Session beim Start, hält der Hook die Standardausgabe des Servers offen. Die Lösung ist `> .claude/logs/x.log 2>&1 &` (oder `nohup`), dann kehrt der Hook sofort zurück. Guter Moment für „Nebenwirkungen in Hooks“: Prüfen und melden ist der sichere Standard, Prozesse starten eine bewusste Wahl.
- Der Test mit zwei Accounts ist der Schritt, den viele überspringen – beim Gang durch den Raum
  darauf achten.

## Zeitbedarf

~50 Minuten.
