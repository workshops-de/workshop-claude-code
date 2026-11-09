## Lernziele

- **Feature:** `.claude/rules/`, pfadbezogene Regeln über `paths`-Frontmatter, `@`-Imports, `/memory`
  und `/context`, um zu prüfen, was geladen wurde.
- **Konzepte:** Memory ist geschichtet; Pfadbezug hält den Kontext schlank; Imports ordnen, sparen
  aber keinen Kontext.
- **Übungsfeld:** die BookMonkey-Domäne und der API-Vertrag – Glossar, Entitätsmodell, eine
  kompakte Vertragszusammenfassung und API-Client-Konventionen.
- **Takeaways:** Erst auf die Bedeutung einigen, dann Code; dorthin legen, wo der Agent es in jeder
  Session neu liest.

## Hinweise zur Durchführung

- Das baut direkt auf der `CLAUDE.md`-Aufgabe auf – rahmt es als „was tun, wenn eine Datei nicht
  mehr reicht“.
- Die Prüfung mit `/context all` in einer frischen Session zeigt die Regel ohne Pfadbezug (nur im
  `-p`-Modus geprüft, probiert es also vorher einmal interaktiv aus). Eine pfadbezogene Regel
  erschien im Test nicht in `/context` (2 von 2), auch nicht nach dem Lesen: Der Beweis ist die
  Zeile `Loaded .claude/rules/...` im Gespräch.
- Irgendjemand importiert die rohe `openapi.json` – lasst ihn, und vergleicht dann den
  `/context`-Tokenverbrauch mit dem Nachbarn, der die Zusammenfassung importiert hat. Starker
  Lernmoment.
- `id` vs. `isbn` ist die Falle, die später zuschlägt (falsche Detail-URLs, kaputte
  Bearbeitungsformulare). Steht es nicht im Glossar, fragt die Gruppe, warum es dort stehen sollte.
- Die ausgelieferte `openapi.json` ist nicht die ganze Wahrheit: Sie listet für `PUT`, `PATCH` und
  `DELETE` nur `200`/`400`, während die laufende API bei `PATCH` und `DELETE` für eine unbekannte
  ISBN mit `404` antwortet (`PUT` antwortet mit `400`). Guter Beleg dafür, dass ein paar echte
  Antworten in Schritt 2 gehören.
- In zsh URLs mit `?` in Anführungszeichen setzen (`curl "localhost:4730/books?_limit=3"`), sonst
  bricht zsh mit `no matches found` ab.
- `docs/openapi.json` kommt in Aufgabe 200 als der Vertrag wieder, den das eigene Backend erfüllen
  muss – erwähnt, dass die Datei committet werden sollte.

## Zeitbedarf

~30 Minuten.
