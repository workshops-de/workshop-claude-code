<details>
<summary>💡 Tipp 1: Label gesetzt, aber nichts passiert</summary>

Schaut in den Tab **Actions** eures Forks. Gar kein Lauf bedeutet meistens, dass Workflows im Fork
noch deaktiviert sind oder dass der Label-Name nicht exakt zur `if:`-Bedingung passt. Ein Lauf, der
früh fehlschlägt, bedeutet meistens, dass das Secret fehlt oder die Claude GitHub App nicht auf dem
Fork installiert ist.

</details>

<details>
<summary>💡 Tipp 2: Das Issue oder der PR landet im falschen Repository</summary>

Mit zwei Remotes nimmt `gh` womöglich das Original-Repository. Übergebt jedem `gh`-Befehl
`--repo $FORK` oder führt einmal `gh repo set-default` aus und wählt euren Fork.

</details>

<details>
<summary>💡 Tipp 3: In der CI ist enger besser</summary>

Auf einem Runner genehmigt niemand Tool-Aufrufe. Was `--allowedTools` erlaubt, darf Claude tun,
und Aufrufe ohne Freigabepflicht (etwa lesende Bash-Befehle) laufen auch ohne Eintrag.
Fragt euch bei jedem Tool in der Liste: Braucht der Modus `analyse` es?

</details>

<details>
<summary>💡 Tipp 4: Der Kommentar klingt selbstsicher</summary>

Behandelt ihn wie ein erstes Review von einem neuen Kollegen. Öffnet die Dateien, die er nennt. Ein
falscher Zeilenbereich oder eine Ursache ohne Belege ist ein Signal, den Prompt zu schärfen, nicht,
ihm mehr zu vertrauen.

</details>
