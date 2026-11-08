<details>
<summary>💡 Tipp 1: Zwei Sätze, zwei Hinweise</summary>

Das Ticket sagt zwei verschiedene Dinge: Eine Reihe ist schon kaputt, die anderen brechen erst nach
einem Speichern. Eine gute Hypothese erklärt beide Sätze auf einmal. Erklärt eure nur einen, sucht
weiter.

</details>

<details>
<summary>💡 Tipp 2: Einen guten Fall mit einem schlechten vergleichen</summary>

Legt eine Reihe, die funktioniert, neben eine, die nicht funktioniert, und vergleicht alles, was ihr
beobachten könnt. Unterschiede, die ihr benennen könnt, sind Belege; „irgendwas stimmt nicht“ ist
keiner.

</details>

<details>
<summary>💡 Tipp 3: Die Historie fragen</summary>

Sobald ihr wisst, welcher Code beteiligt ist, fragt, wann er sich zuletzt geändert hat und warum.
Eine Commit-Message verrät oft, was der Autor erreichen wollte und woran er nicht gedacht hat.

</details>

<details>
<summary>💡 Tipp 4: Dem ersten Fix widersprechen</summary>

Schlägt Claude einen Fix an der einen Stelle vor, auf die das Ticket zeigt, fragt: Was läuft noch
durch denselben Code? Ein Fix, der nur das Symptom versteckt, kommt als nächstes Ticket zurück.

</details>

<details>
<summary>💡 Tipp 5: Alle Tests auf einmal rot?</summary>

Prüft `node -v`: `bookmonkey-legacy` braucht Node 24 oder neuer (`node:sqlite`).

</details>
