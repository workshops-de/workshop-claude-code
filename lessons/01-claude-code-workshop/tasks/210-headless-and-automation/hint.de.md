<details>
<summary>💡 Tipp 1: Kein Mensch heißt keine Rückfragen</summary>

Gebt immer `--allowedTools` oder einen passenden `--permission-mode` an, sonst bricht der Lauf ab,
sobald er auf eine Aktion trifft, die er nicht automatisch freigeben kann.

</details>

<details>
<summary>💡 Tipp 2: Pipe statt Bash freigeben</summary>

Wenn ihr den Diff per Pipe übergebt, müsst ihr Bash nicht freigeben, nur um ihn zu lesen.

</details>

<details>
<summary>💡 Tipp 3: Die JSON-Ausgabe erfasst auch die Kosten</summary>

`--output-format json` enthält `total_cost_usd`, sodass Skripte die Ausgaben pro Aufruf verfolgen
können.

</details>
