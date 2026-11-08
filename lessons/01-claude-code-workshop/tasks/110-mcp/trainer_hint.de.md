## Lernziele

- **Feature:** `claude mcp add` (stdio vs. remote), Scopes und `.mcp.json`, `/mcp` und
  `claude mcp list`, Kontextkosten von Tool-Ergebnissen.
- **Konzepte:** den Kreis an einem laufenden System schließen; das schlankste Prüfwerkzeug wählen.
- **Übungsfeld:** eine im Browser geprüfte BookMonkey-User-Journey plus ein kleiner Cover-Fallback
  nur für den Client in einer Server-First-App.
- **Erkenntnisse:** harte Einschränkungen zu Beginn nennen; den Agenten sehen lassen, was er gebaut
  hat; verbinden, was man braucht, nicht alles.

## Hinweise zur Durchführung

- Eine anschauliche Demo: Lasst den Agenten die Journey zuerst nur durch Lesen des Codes prüfen,
  dann über den Browser – der Browser-Lauf findet meist etwas (einen Reihen-Link, der `id`
  verwendet, eine Seite, die den Suchbegriff verliert, ein Karten-Raster, das auf Handybreite
  überläuft).
- Netzwerk-/Firewall-Probleme können MCP-Server-Installationen in manchen Umgebungen blockieren –
  haltet eine Aufzeichnung als Ausweichlösung bereit.
- Beobachtet während der Journey die Kontextanzeige: Vollständige Snapshots sind teuer. Guter
  Moment, `/context` zu zeigen und zu besprechen, wann ein `curl` gereicht hätte.
- Das Buch mit dem unsinnigen Cover bleibt in der gemeinsamen API; `POST /dev/reset` räumt auf.
- Snapshots direkt nach `navigate` können fast leer sein, solange Suspense-Boundaries noch
  streamen; bittet den Agenten, auf ein bekanntes Element zu warten (oder eine Sekunde), bevor er
  die Seite liest.
- Im Dev-Modus mit Cache Components kann das DOM eine versteckte Kopie der vorherigen Seite
  behalten (`display: none`). Beobachtungen, die Elemente zählen, können um eine Seite daneben
  liegen; bittet um ausschließlich sichtbare Elemente.
- Typische Funde aus dem Probelauf: ein Konsolenfehler `Next.js encountered the unstable value
  Date.now()` auf Seiten mit Anmeldung (Lösung: `await connection()`, bevor zeitabhängige
  Session-Daten gelesen werden) und Pager-Links, die auf Handybreite nur etwa 20 px hoch sind.

## Zeitbedarf

~45 Minuten.
