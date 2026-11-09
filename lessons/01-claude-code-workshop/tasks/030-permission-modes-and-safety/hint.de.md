<details>
<summary>💡 Tipp 1: Wo ihr anfangt</summary>

Startet sensible oder unbekannte Arbeit in Manual (`default`) oder `plan`; lockert erst, wenn ihr
der Richtung vertraut, die der Agent einschlägt.

</details>

<details>
<summary>💡 Tipp 2: Grenzen können verloren gehen</summary>

Im Auto Mode liest der Klassifikator eine Grenze, die ihr formuliert, neu aus dem Transcript; in
Manual folgt ihr nur das Modell. In beiden Fällen kann sie verloren gehen, wenn der Kontext
kompaktiert wird. Für eine harte Garantie fügt eine Deny-Regel hinzu, statt euch allein auf das
Gespräch zu verlassen.

</details>

<details>
<summary>💡 Tipp 3: bypassPermissions</summary>

`bypassPermissions` gehört nur in Wegwerf-Umgebungen, die isoliert sind, niemals in ein Repository,
das euch wichtig ist.

</details>

<details>
<summary>💡 Tipp 4: Eine Regel scheint nichts zu bewirken</summary>

Eine Deny-Regel schlägt eine Allow-Regel, in derselben Datei oder in jeder anderen. Regeln werden
nicht danach sortiert, wie genau sie sind. `/permissions` zeigt, aus welcher Settings-Datei jede
Regel kommt.

</details>
