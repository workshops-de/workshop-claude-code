<details>
<summary>💡 Tipp 1: Isolation macht Fehler billig</summary>

Längere autonome Läufe verstärken gute wie schlechte Entscheidungen – mit einem Worktree ist ein
schlechter Lauf schnell verworfen.

</details>

<details>
<summary>💡 Tipp 2: Der Evaluator sieht nur das Transkript</summary>

Er führt selbst keine Befehle aus. „Das Backend ist fertig“ lässt sich nicht beurteilen;
„`npm run contract` endet mit 0“ schon – denn Claude führt es aus, und die Ausgabe landet in der
Unterhaltung.
Er verhindert auch nichts: Für harten Schutz nutzt einen Hook oder eine Deny-Regel.

</details>

<details>
<summary>💡 Tipp 3: Ein wiederholter Block ist ein Signal</summary>

Blockiert der Klassifikator des Auto Mode dieselbe Aktion immer wieder, ist das ein Signal und kein
Fehler – lest nach, warum, bevor ihr die Berechtigungen erweitert.

</details>

<details>
<summary>💡 Tipp 4: Im Worktree fehlt eure Arbeit</summary>

Prüft `git log` im Worktree. Ohne `baseRef` auf `head` startet er beim Standard-Branch, eure Commits
aus Schritt 1 sind dann nicht da.

</details>
