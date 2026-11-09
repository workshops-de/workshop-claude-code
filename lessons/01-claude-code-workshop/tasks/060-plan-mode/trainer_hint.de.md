## Lernziele

- **Feature:** Plan Mode als Steuerungsschleife – aktivieren, einen Plan verfeinern, ihn mit
  `Ctrl+G` bearbeiten, beim Bestätigen den Ausführungsmodus wählen.
- **Konzepte:** Die günstigste Korrektur passiert vor der ersten Änderung; die Qualität des Plans
  bestimmt, wie viel Autonomie man sicher gewähren kann.
- **Übungsfeld:** BookMonkey-App-Router-Scaffold mit Route Groups für öffentliche vs. geschützte
  Bereiche, angebunden an die laufende `bookmonkey-api`.
- **Takeaways:** Dem Plan widersprechen, dann die App starten, dann committen, was man verantwortet.

## Hinweise zur Durchführung

- Die Teilnehmenden haben den Plan Mode in der Grundlagen-Aufgabe als Schalter gesehen, der Änderungen sperrt:
  rahmt diese Aufgabe als die „echte“ Version, in der Widerspruch das Ergebnis tatsächlich verändert.
- Prüft, ob die Leute den Plan wirklich hinterfragen; ein häufiger Fehler ist, den ersten Entwurf
  anzunehmen. Bittet eine Person zu zeigen, wie sich ihr Plan verändert hat.
- `Ctrl+G` öffnet den Editor aus `$VISUAL`, sonst aus `$EDITOR`. GUI-Editoren brauchen `--wait`
  (zum Beispiel `code --wait`). Haltet eine schnelle Lösung bereit, falls sich nichts öffnet.
- `bookmonkey-api` deklariert Node.js >=26: Alle sollten Node 26 (aktuelles LTS) nutzen. Das vor
  der Session prüfen. Portkonflikte auf 4730 löst man mit `npx bookmonkey-api --port <n>` plus einer
  dazu passenden `NEXT_PUBLIC_API_URL`.
- Rechnet damit, dass Agenten ungefragt shadcn/ui oder eine Data-Fetching-Library vorschlagen –
  genau hier ein guter Anlass zu widersprechen; shadcn kommt bewusst erst in der Skills-Aufgabe.
- Next.js-16-Stolperfallen aus dem Probelauf: Cache Components ist standardmäßig an, daher bricht
  `export const dynamic` den Build mit `Route segment config "dynamic" is not compatible
  with nextConfig.cacheComponents` (Fix: Fetch zur Anfragezeit innerhalb von `<Suspense>`, siehe Tipp 4).
  Nach dem Löschen der Template-`app/page.tsx` kann `tsc` wegen eines veralteten `.next/types`
  `Cannot find module '../../app/page.js'` melden; `rm -rf .next` behebt das.
- `create-next-app` schreibt außerdem eine `AGENTS.md` mit Next.js-Hinweisen. Claude Code liest sie
  nur, solange das Repo keine `CLAUDE.md` hat; sobald es eine `CLAUDE.md` gibt, wird sie nicht mehr
  geladen, es sei denn, die `CLAUDE.md` importiert sie mit `@AGENTS.md`.
- Bekannte Stolperfalle: Tote Navigationslinks auf noch nicht gebaute Seiten führen bis zu den
  jeweiligen Aufgaben zu 404 – das ist erwartet.

## Zeitbedarf

~45 Minuten inklusive Installation/Setup.
