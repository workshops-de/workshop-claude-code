<details>
<summary>💡 Tipp 1: Der Server startet, aber /mcp zeigt „failed“</summary>

Führt den genauen Befehl aus der `.mcp.json` selbst im Repository-Stamm aus. Ein stdio-Server, der
irgendetwas nach stdout schreibt (ein `console.log` beim Start), bricht das Protokoll; loggt mit
`console.error` nach stderr. Prüft auch, ob die API auf Port 4730 läuft.

</details>

<details>
<summary>💡 Tipp 2: Claude ruft immer wieder dasselbe Tool auf</summary>

Schaut auf die Tool-Beschreibungen und Ergebnisse, nicht auf Claude. Sagt eine Beschreibung, was das
Tool zurückgibt? Liefert `get_series` wirklich die ganze Reihe oder nur den nächsten Band? Ein Tool,
das eine ganze Frage beantwortet, spart viele Aufrufe.

</details>

<details>
<summary>💡 Tipp 3: Zu große Ergebnisse</summary>

Liefert ein Tool vollständige Buchobjekte mit langen Abstracts, füllt jeder Aufruf euren Kontext.
Gebt nur die Felder zurück, die die Frage braucht, und lasst Claude Details über ein zweites Tool
anfragen, wenn es muss.

</details>

<details>
<summary>💡 Tipp 4: Der App-Build beanstandet den neuen Ordner</summary>

Wenn euer Next.js-Type-Check oder Lint `tools/bookmonkey-mcp` aufgreift, schließt den Ordner in der
`tsconfig.json` (`"exclude"`) und in eurer ESLint-Konfiguration aus. Der Server ist ein eigenes
Package mit eigener `package.json`.

</details>
