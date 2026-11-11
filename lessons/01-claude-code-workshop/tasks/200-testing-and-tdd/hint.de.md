<details>
<summary>💡 Tipp 1: „Nutze TDD“ ausdrücklich sagen</summary>

Sonst macht Claude es nicht zuverlässig. Bittet zuerst nur um Tests, prüft sie, und bittet erst in einem eigenen Prompt um die Implementierung.

</details>

<details>
<summary>💡 Tipp 2: Erst grün gegen die API</summary>

Ein Contract-Test, der gegen die `bookmonkey-api` fehlschlägt, beschreibt einen Wunsch, nicht den Vertrag. Bringt die Suite auf Port 4730 auf grün, bevor ihr das Backend baut. Korrigiert den Test, nie die API.

</details>

<details>
<summary>💡 Tipp 3: Tests, die Bücher anlegen, hinterlassen Spuren</summary>

Jeder Test nutzt eine eigene ISBN und löscht sein Buch mit `DELETE`. Ist doch etwas liegen geblieben, stellt `curl -X POST http://localhost:4730/dev/reset` die Daten der API wieder her.

</details>
