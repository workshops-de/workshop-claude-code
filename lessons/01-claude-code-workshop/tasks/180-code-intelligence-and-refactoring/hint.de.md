<details>
<summary>💡 Tipp 1: Testet, was ist, nicht, was sein sollte</summary>

Ein Characterisation-Test hält die heutige Ausgabe fest, auch wenn sie seltsam aussieht. Wenn ihr
beim Schreiben des Tests den erwarteten Wert „korrigiert“, könnt ihr nicht mehr erkennen, ob das
Refactoring das Verhalten geändert hat. Notiert die Auffälligkeit und haltet den Test ehrlich.

</details>

<details>
<summary>💡 Tipp 2: Das Inventar ist die eigentliche Arbeit</summary>

Lasst euch das Inventar zweimal auf unterschiedliche Weise geben: einmal durch Durchsuchen des
Codes, einmal durch Verfolgen der Daten (woher kommt dieser Wert, wohin geht er als Nächstes?).
Die Stellen, die nur eine der beiden Methoden findet, sind die, die später kaputtgehen.

</details>

<details>
<summary>💡 Tipp 3: Gleiches Verhalten schließt die Fehlerpfade ein</summary>

„Verhält sich wie zuvor“ umfasst mehr als den Happy Path. Deckt auch die Fehlerpfade des Codes ab,
den ihr anfasst, nicht nur die Requests, die gelingen.

</details>

<details>
<summary>💡 Tipp 4: Lasst manchmal die IDE gewinnen</summary>

„Dieses Symbol überall umbenennen“ und „diese Methode extrahieren“ gehen in der IDE meist
schneller. Spart euch den Agenten für die Teile auf, die Lesen und Urteilsvermögen brauchen.

</details>

<details>
<summary>💡 Tipp 5: Alle Tests auf einmal rot?</summary>

Prüft `node -v`: `bookmonkey-legacy` braucht Node 24 oder neuer (`node:sqlite`).

</details>
