<details>
<summary>💡 Tipp 1: Ein Plan, dem ihr nie widersprecht, ist nur ein Abnicken</summary>

Fragt „Warum ist dieser Schritt nötig?“ bei allem, was euch überrascht – besonders bei zusätzlichen
Libraries. Haltet das erste Scaffold minimal; die Komponenten-Library kommt bewusst erst in der
Skills-Aufgabe.

</details>

<details>
<summary>💡 Tipp 2: Eure Änderung schlägt einen langen Korrektur-Prompt</summary>

Wenn ihr drei Sätze bräuchtet, um eine Änderung zu erklären, ist es oft schneller, den Plan mit
`Ctrl+G` zu öffnen und es einfach so hinzuschreiben, wie ihr es wollt.

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
