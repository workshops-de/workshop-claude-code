## Lernziele

- **Skills:** Claude Code installieren; eine Installation von Anfang bis Ende prüfen; einfache
  Fehlersuche.
- **Konzepte:** die CLI als terminal-natives Tool; Anmeldung und Session-Persistenz.
- **Takeaways:** Eine jetzt geprüfte Installation verhindert Zeitverlust in jeder späteren Aufgabe.

## Hinweise zur Durchführung

- Das ist bewusst eine **reine Setup-Aufgabe**, ausgelagert aus „Claude Code Grundlagen“, damit
  Installationsprobleme nicht die Zeit auffressen, die zum Lernen des Tools gedacht ist.
- Die Voraussetzungen (Node.js-Version, Account-Registrierung) unbedingt **vor** dem Workshop an
  die Teilnehmenden schicken, damit diese Aufgabe Minuten dauert und nicht den Großteil des ersten
  Blocks.
- Typische Blocker: veraltetes Node.js, Firmen-Proxys/Firewalls, die das Installationsskript oder
  die Anmeldung blockieren, und fehlende `PATH`-Updates nach der Installation. Eine Ausweichlösung
  (z. B. einen vorbereiteten Codespace/Devcontainer) für alle bereithalten, die nicht schnell
  weiterkommen.
- Alle bitten, **Node.js 26** (aktuelles LTS) zu installieren: `bookmonkey-api` verlangt
  `node >=26`, und eine falsche Version fällt sonst erst in der Plan-Mode-Aufgabe auf.
- Durch den Raum gehen und bei allen Teilnehmenden bestätigen, dass `claude --version` und
  `claude doctor` funktionieren, bevor es mit der Grundlagen-Aufgabe weitergeht – eine kaputte Installation zieht
  sich sonst durch den ganzen Tag.

## Zeitbedarf

~15 Minuten für die meisten Teilnehmenden; Netzwerkbeschränkungen in Firmen können das deutlich
verlängern.
