<details>
<summary>💡 Tipp 1: Kein Mensch heißt keine Rückfragen</summary>

Gebt in Skripten `--allowedTools` oder einen passenden `--permission-mode` an. Sonst wird alles
abgelehnt, was eine Freigabe bräuchte.

</details>

<details>
<summary>💡 Tipp 2: Pipe statt Bash freigeben</summary>

Wenn ihr den Diff per Pipe übergebt, müsst ihr Bash nicht freigeben, nur um ihn zu lesen.

</details>

<details>
<summary>💡 Tipp 3: Kein Ergebnis im Skript?</summary>

Gebt die komplette JSON-Antwort einmal ohne `jq` aus. Das Ergebnis nach Schema steht im Feld `structured_output`.

</details>

<details>
<summary>💡 Tipp 4: Der Push wird nicht gestoppt?</summary>

Startet `./review.sh <branch>; echo $?` einmal von Hand. Der Hook stoppt den Push nur, wenn das Skript mit einer Zahl ungleich 0 endet. Prüft auch, ob die Hook-Datei ausführbar ist (macOS und Linux: `chmod +x`).

</details>
