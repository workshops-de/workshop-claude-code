<details>
<summary>💡 Tipp 1: Der Entwurf von /init ist lang</summary>

Das ist normal. Eure Aufgabe ist, sie auf das Wesentliche zu kürzen, nicht alles zu behalten. Ein
guter Test für jede Zeile: Würde ein neues Teammitglied das brauchen, und würde Claude es ohne sie
falsch machen?

</details>

<details>
<summary>💡 Tipp 2: Zwei Quellen, eine Wahrheit</summary>

`/init` liest auch die README und kann daher übernehmen, was dort steht. Fragt bei jeder Aussage,
woher sie kommt: aus der README, aus einer Konfigurationsdatei oder aus dem Code selbst. Nur die
letzten beiden sind Belege.

</details>

<details>
<summary>💡 Tipp 3: Befehle exakt halten</summary>

Haltet Befehle exakt und kopierbar, und führt jeden einmal aus. Der Agent verwendet sie
wortwörtlich.

</details>

<details>
<summary>💡 Tipp 4: Die Unterverzeichnis-Datei nachweisen</summary>

Startet eine neue Session und stellt eine Frage, für die Claude nichts in `api/` öffnen muss: Die Antwort bleibt auf Deutsch. Lasst es dann eine Datei in `api/` lesen und fragt erneut.

</details>

<details>
<summary>💡 Tipp 5: Alle Tests auf einmal rot?</summary>

Prüft `node -v`: `bookmonkey-legacy` braucht Node 24 oder neuer (`node:sqlite`).

</details>
