<details>
<summary>💡 Tipp 1: Erst nur lesend starten</summary>

Setzt `tools: ['Read', 'Glob', 'Grep']`, bevor ihr Schreib- oder Bash-Tools ergänzt. Eine
Schreibaufgabe erzeugt dann keine Datei.

</details>

<details>
<summary>💡 Tipp 2: Die Konfiguration eingrenzen</summary>

Das SDK liest standardmäßig eure `.claude/`-Konfiguration – grenzt `settingSources` ein, dann ist
der Agent sauber und reproduzierbar.

</details>

<details>
<summary>💡 Tipp 3: Richtig authentifizieren</summary>

Nutzt einen API-Key (oder Bedrock-/Vertex-/Foundry-Zugangsdaten) – der claude.ai-Login ist nicht für
SDK-Produkte von Drittanbietern gedacht.

</details>
