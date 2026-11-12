<details>
<summary>💡 Tipp 1: Isolation macht Fehler billig</summary>

Längere autonome Läufe verstärken gute wie schlechte Entscheidungen, mit einem Worktree ist ein
schlechter Lauf schnell verworfen.

</details>

<details>
<summary>💡 Tipp 2: Der Evaluator sieht nur das Transkript</summary>

Er führt selbst keine Befehle aus. „Das Backend ist fertig“ lässt sich nicht beurteilen;
„`npm run contract` endet mit 0“ schon, denn Claude führt es aus, und die Ausgabe landet in der
Unterhaltung.
Er verhindert auch nichts: Für harten Schutz nutzt einen Hook oder eine Deny-Regel.

</details>

<details>
<summary>💡 Tipp 3: Ein wiederholter Block ist ein Signal</summary>

Blockiert der Klassifikator des Auto Mode dieselbe Aktion immer wieder, ist das ein Signal und kein
Fehler, lest nach, warum, bevor ihr die Berechtigungen erweitert.

</details>

<details>
<summary>💡 Tipp 4: Im Worktree fehlt, was nicht committet ist</summary>

Fehlen die neuen Tests im Worktree, habt ihr sie in Schritt 2 nicht committet oder nicht gepusht. Mit Remote startet der Worktree beim Stand von `main` auf `origin`, nicht beim lokalen Commit.

</details>
