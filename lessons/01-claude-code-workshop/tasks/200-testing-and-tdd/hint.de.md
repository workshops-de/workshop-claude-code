<details>
<summary>💡 Tipp 1: „use TDD“ ausdrücklich sagen</summary>

Sonst macht der Agent es nicht zuverlässig. Bittet nur um Tests, prüft sie, führt sie aus – und
bittet dann in einem separaten Prompt um die Implementierung.

</details>

<details>
<summary>💡 Tipp 2: Erst grün gegen die Referenz</summary>

Ein Contract-Test, der gegen die `bookmonkey-api` fehlschlägt, beschreibt einen Wunsch, nicht den
Vertrag. Bringt die Suite auf Port 4730 auf grün, bevor euer Backend existiert.

</details>

<details>
<summary>💡 Tipp 3: Tests, die Bücher anlegen, hinterlassen Spuren</summary>

Nutzt pro Testlauf eindeutige ISBNs und räumt hinterher auf – `POST /dev/reset` stellt die
Seed-Daten der Referenz-API wieder her. Für euer Backend nutzt ihr eine Wegwerf-Datenbank, nie eure
Entwicklungsdaten.

</details>
