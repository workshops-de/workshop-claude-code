## Lernziele

- **Feature:** agentengestütztes TDD – ausdrückliches Test-first-Prompting, Tests vor dem Code
  prüfen, Randfälle suchen, Tests vor „Korrekturen“ schützen, ein lauffähiger Gate-Befehl.
- **Konzepte:** Tests als Fertig-Signal; Characterisation-/Contract-Tests; kurzlebige
  Testdatenbanken.
- **Übungsfeld:** Contract-Tests gegen die Referenz-`bookmonkey-api`, dann die ersten zwei
  Endpoints eines eigenen NestJS-Backends, getrieben von derselben Suite.
- **Takeaways:** TDD ausdrücklich verlangen; die Tests zuerst gegen die Realität richtig bekommen;
  Gates bauen, die der Agent selbst ausführen kann.

## Hinweise zur Durchführung

- Den roten Faden setzen: Seit Aufgabe 090 wissen alle, dass die API das Token nicht erzwingt –
  hier beginnt das eigene Backend. Aufgabe 230 bringt es autonom zu Ende.
- Der Schritt „erst grün gegen die Referenz“ ist die wichtige Wendung. Agenten schreiben Tests
  gern aus der OpenAPI-Spec, die die echte API nicht ganz erfüllt – den Test zu korrigieren ist
  die Lektion.
- Darauf achten, dass Agenten Tests ändern, um sie grün zu machen. Falls das passiert, die Idee des
  Hooks zum Schutz der Tests aus dem Bonus zeigen.
- Tests, die Bücher per `POST` anlegen, brauchen auf beiden Zielen ein Aufräumen. Gegen die
  Referenz-API funktioniert `POST /dev/reset`, setzt aber die Instanz für alle zurück, die darauf
  arbeiten; ein `DELETE` in `afterEach` ist netter. Das eigene Backend braucht dann früh
  `DELETE /books/:isbn` (der Probelauf hat es genau deshalb in dieser Aufgabe gebaut).
- Der Gate-Befehl braucht die laufende Referenz-API auf 4730, ist also nicht hermetisch. Für den
  Workshop in Ordnung; sollte aber laut gesagt werden.
- Port-Konflikte: Next.js nutzt 3000, die Referenz-API 4730 – für das eigene Backend 3001
  vorschlagen.
- Wenn die Zeit knapp ist, reicht `GET /books/:isbn` allein, um die Schleife zu sehen; `POST` kann
  nach 230 wandern.
- Bereitet Headless & Automation direkt vor: Der hier gebaute Gate-Befehl wird als Nächstes in ein
  Skript verpackt.

## Zeitbedarf

ca. 60 Minuten.
