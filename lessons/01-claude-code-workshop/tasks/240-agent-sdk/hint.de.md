<details>
<summary>💡 Tipp 1: Erst nur lesend starten</summary>

Setzt `tools: ['Read', 'Glob', 'Grep']`, bevor ihr Schreib- oder Bash-Tools ergänzt. Eine
Schreibaufgabe erzeugt dann keine Datei.

</details>

<details>
<summary>💡 Tipp 2: Die Konfiguration eingrenzen</summary>

Das SDK liest standardmäßig eure `.claude/`-Konfiguration. Grenzt `settingSources` ein, dann ist
der Agent sauber und reproduzierbar.

</details>

<details>
<summary>💡 Tipp 3: Richtig authentifizieren</summary>

Kommt ein Fehler wie `Not logged in`, meldet euch zuerst in Claude Code an. Für Produkte, die andere
nutzen, sehen die Docs einen API-Key (oder Bedrock-/Vertex-/Foundry-Zugangsdaten) vor.

</details>
