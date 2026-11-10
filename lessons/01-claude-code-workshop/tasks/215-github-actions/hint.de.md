<details>
<summary>💡 Tipp 1: Der Lauf in Schritt 2 oder 3 fragt oder bricht ab</summary>

Startet den Befehl im Projektordner von `bookmonkey-legacy`, im Terminal der Desktop-App. Unter Windows nehmt die Git Bash. Braucht ein Aufruf eine Freigabe und fehlt in `--allowedTools`, lehnt Claude ihn ab. Das ist gewollt.

</details>

<details>
<summary>💡 Tipp 2: In der CI ist enger besser</summary>

Auf einem Server genehmigt niemand Tool-Aufrufe. Was `--allowedTools` nennt, läuft ohne Rückfrage. Fragt euch bei jedem Tool in der Liste: Braucht der Modus `analyse` es?

</details>

<details>
<summary>💡 Tipp 3: Die Antwort klingt selbstsicher</summary>

Behandelt sie wie ein erstes Review von einem neuen Kollegen. Öffnet die Dateien, die sie nennt. Ein falscher Zeilenbereich oder eine Ursache ohne Belege ist ein Signal, den Prompt zu schärfen, nicht, ihr mehr zu vertrauen.

</details>
