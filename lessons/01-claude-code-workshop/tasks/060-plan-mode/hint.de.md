<details>
<summary>💡 Tipp 1: Ein Plan, dem ihr nie widersprecht, ist nur ein Abnicken</summary>

Fragt „Warum ist dieser Schritt nötig?“ bei allem, was euch überrascht – besonders bei zusätzlichen
Libraries. Haltet das erste Scaffold minimal; die Komponenten-Library kommt bewusst erst in der
Skills-Aufgabe.

</details>

<details>
<summary>💡 Tipp 2: Die Korrektur wird lang</summary>

Nennt in der Korrektur nur das, was sich ändern soll, und schließt mit „Ändere noch nichts“.
So bleibt es ein Satz, und Claude zeigt euch erst den neuen Plan.

</details>

<details>
<summary>💡 Tipp 3: Die Seite ist leer, aber die API läuft?</summary>

Prüft, was der Browser tatsächlich angefragt hat und ob die Anfrage auf dem Server oder im Client
lief. `NEXT_PUBLIC_`-Variablen werden zur Build-Zeit eingesetzt – startet den Dev-Server neu, nachdem
ihr `.env.local` geändert habt.

</details>

<details>
<summary>💡 Tipp 4: Der Build meldet `"dynamic" is not compatible with cacheComponents`</summary>

Das aktuelle `create-next-app` (Next.js 16) schaltet Cache Components ein. Der alte Fix
`export const dynamic = "force-dynamic"` bricht den Build jetzt. Daten, die zur Anfragezeit geladen
werden, müssen stattdessen innerhalb einer `<Suspense>`-Boundary gerendert werden: Verschiebt den
Fetch in eine eigene asynchrone Server Component und umschließt sie damit.

</details>
