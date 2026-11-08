## Weiterführend: mehr Server, Governance und Skalierung

- **Ein zweiter Server**: Verbindet einen Datenbank-MCP-Server und lasst den Agenten eine Tabelle
  untersuchen, oder einen Issue-Tracker, um die Aufgabe zu lesen, an der ihr arbeitet.
- **Mit dem Team teilen**: Fügt euren Browser-Server mit `--scope project` erneut hinzu und
  committet die `.mcp.json`; Teammitglieder bestätigen Projekt-Server bei der ersten Nutzung.
- **Managed MCP**: Organisationen können mit Allowlists und Denylists einschränken, welche Server
  Nutzer hinzufügen dürfen.
- **MCP im Agent SDK**: Bindet dieselben Server in programmatische Agenten ein.
- **Browser-Check auf `bookmonkey-legacy`**: Startet die API (Port 4780) und die Web-App
  (Port 5180) und lasst euren Browser-Server die App fünf Minuten lang wie ein Kunde benutzen.
  Wiederholt das mit einem langsamen Netzwerk (Throttling, zum Beispiel „Slow 4G“ in den Chrome
  DevTools). Bittet Claude, **Beobachtungen statt Urteile** zu berichten: was es eingegeben oder
  geklickt hat, was die Seite zeigte, in welcher Reihenfolge und wie lange es dauerte. Vergleicht
  den schnellen und den langsamen Lauf selbst.

Skizziert eine Allowlist-Richtlinie für MCP-Server in eurer eigenen Organisation.
