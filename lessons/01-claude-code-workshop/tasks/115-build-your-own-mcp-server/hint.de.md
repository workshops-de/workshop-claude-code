<details>
<summary>💡 Tipp 1: /mcp zeigt den Server nicht oder als „failed“</summary>

Habt ihr nach dem Registrieren eine neue Session gestartet? Läuft die API auf Port 4730? Bittet Claude: „Starte den Server aus der .mcp.json einmal selbst und sag mir, was er ausgibt.“ Ein Server, der etwas nach stdout schreibt (zum Beispiel ein `console.log`), stört die Verbindung; Logs gehören nach stderr (`console.error`).

</details>

<details>
<summary>💡 Tipp 2: Claude nutzt das neue Tool nicht</summary>

Startet nach jeder Änderung am Server eine neue Session. Schaut dann auf den Namen und die Beschreibung des Tools: Sagt die Beschreibung, für welche Fragen es gedacht ist? Bittet Claude, sie genauer zu formulieren.

</details>

<details>
<summary>💡 Tipp 3: Die Antwort ist sehr lang</summary>

Bittet Claude, ein Tool nur die Felder zurückgeben zu lassen, die die Frage braucht. Jedes Ergebnis landet in eurem Kontext.

</details>
