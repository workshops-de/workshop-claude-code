<details>
<summary>💡 Tipp 1: Testet, was ist, nicht, was sein sollte</summary>

Ein Characterisation-Test hält die heutige Ausgabe fest, auch wenn sie seltsam aussieht. Wenn ihr beim Schreiben des Tests den erwarteten Wert „korrigiert“, könnt ihr nicht mehr erkennen, ob das Refactoring das Verhalten geändert hat. Notiert die Auffälligkeit und haltet den Test ehrlich.

</details>

<details>
<summary>💡 Tipp 2: Gleiches Verhalten schließt die Fehlerpfade ein</summary>

„Verhält sich wie zuvor“ umfasst mehr als den Happy Path. Die Tests sollen auch Anfragen ohne Login und fehlerhafte Eingaben festhalten, nicht nur die, die gelingen.

</details>

<details>
<summary>💡 Tipp 3: Claude will nebenbei aufräumen?</summary>

Sagt es klar: Verhalten bleibt, Auffälligkeiten kommen nur in eine Liste. Ein Fix im selben Diff wie das Verschieben macht beides unlesbar.

</details>

<details>
<summary>💡 Tipp 4: Ein Test ist rot</summary>

Haltet an und entscheidet: Hat der Schritt das Verhalten geändert, dann macht ihn rückgängig (`git restore .` für ungespeicherte Änderungen). Hat der Test etwas Falsches festgehalten, korrigiert den Test in einem eigenen Commit.

</details>

<details>
<summary>💡 Tipp 5: Alle Tests rot, oder der Hook greift nicht?</summary>

Prüft `node -v`: `bookmonkey-legacy` braucht Node 24 oder neuer (`node:sqlite`). Meldet nur der Stop-Hook alles rot, während `npm test` im Terminal grün ist, läuft der Hook vermutlich mit einer anderen Node-Version. Lasst Claude im Hook `node -v` ausgeben und vergleicht. Greift der Hook gar nicht, habt ihr nach dem Einfügen eine neue Session gestartet? Lasst Claude prüfen, ob `.claude/settings.local.json` gültiges JSON ist.

</details>
