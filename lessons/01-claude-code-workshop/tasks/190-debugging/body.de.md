## Überblick

Nutzt Claude Code als Debugging-Partner bei einem Fehlerbericht echter Nutzer. Ihr gebt ihm Belege
statt Vermutungen, lasst es das Problem über die Schleife Reason → Act → Observe verfolgen und
akzeptiert keinen Fix, bevor ihr die **Ursache** kennt, wisst, warum sie sich versteckt, und wann
sie hineingekommen ist. Gutes Debugging mit einem Agenten heißt vor allem, guten Kontext zu liefern
und den ersten plausiblen Patch abzulehnen.

## Das Feature

Claude debuggt gut, wenn es _beobachten_ kann: eine Reproduktion ausführen, Logs lesen, den Zustand
untersuchen und die Historie durchgraben. Eure Aufgabe ist, diese Schleife aufzusetzen und ehrlich
zu halten.

- **Belege hinein.** Fügt das Ticket ein, die genauen Schritte, was ihr erwartet habt und was ihr
  gesehen habt. Lasst Claude es reproduzieren, bevor es viel Code liest: Ein fehlschlagender
  `curl` oder Test schlägt jede Theorie.
- **Hypothesen heraus.** Bittet um zwei oder drei konkurrierende Hypothesen und einen günstigen
  Test für jede. Lasst Claude sagen, welche Beobachtung jede einzelne ausschließen würde.
- **Historie ist ein Beleg.** `git log -- <path>`, `git log -S '<text>'`, `git blame -L` und
  `git show <sha>` verraten, wann sich ein Verhalten geändert hat und warum jemand es geändert hat.
  Claude kann sie alle für euch ausführen.
- **Ursache, nicht Symptom.** Ein Fix an der einen Stelle, die das Ticket nennt, ist oft der
  kleinste Diff und der falsche. Fragt: Welche anderen Pfade laufen durch denselben Code?
- **Beweisen.** Ein Regressionstest, der vor dem Fix fehlschlägt und danach besteht.

## Anwendung auf BookMonkey Legacy

> **Repo / Ports:** euer `bookmonkey-legacy`-Clone (Node.js 24 oder neuer), API auf
> http://localhost:4780, Web-App auf http://localhost:5180
>
> **Login:** Admin `admin@bookmonkey.example` / `admin2021`

Das Übungsfeld ist euer Clone von [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy).
Dieses Ticket kam vom Bibliotheksteam. Es ist alles, was ihr habt:

> **Ticket #412: „Nächster Band“ führt ins Nichts**
>
> Seit einer Weile führt der Link „nächster Band“ bei The Lord of the Rings ins Nichts. Andere Reihen
> funktionieren, bis jemand im Admin ein Buch speichert.

## Voraussetzungen

- Der `bookmonkey-legacy`-Clone mit `npm install` und einem frischen `npm run db:reset`
- Ein frischer Branch von `main`, nicht von eurem Refactoring-Branch: Committet oder stasht, was
  übrig ist, dann `git switch main && git switch -c fix/ticket-412`
- API (`npm run dev:api`) und Web-App (`npm run dev:web`) laufen in zwei Terminals
- Admin-Login aus der Tabelle mit den Test-Logins im README
- Optional: der `legacy-ops`-MCP-Server aus dem Bonus von „MCP: Einen eigenen MCP-Server bauen“

## Schritte

1. **Den ersten Satz reproduzieren.** Öffnet in der Web-App „The Fellowship of the Ring“, den
   ersten Band von The Lord of the Rings, und folgt den Reihen-Links vorwärts und zurück. Reproduziert
   es dann ohne den Browser: Lasst Claude die API-Aufrufe hinter der Seite finden und sie mit
   `curl` ausführen. Schreibt den genauen Request auf, der fehlschlägt.
2. **Den zweiten Satz reproduzieren.** Wählt eine Reihe, die funktioniert, speichert eines ihrer
   Bücher im Web-Admin unter http://localhost:5180/admin/books (es gibt auch ein altes Admin unter
   http://localhost:4780/admin-old/; nutzt hier das Web-Admin), ohne etwas Wesentliches zu ändern,
   und prüft die Reihe erneut. Haltet genau fest, was ihr davor und danach seht.
3. **Die Belege übergeben.** Gebt Claude das Ticket und eure zwei Reproduktionen und bittet im Plan
   Mode um konkurrierende Hypothesen plus einen günstigen Check für jede, bevor es Code anfasst.
4. **Eingrenzen.** Lasst Claude die Checks ausführen. Fragt jedes Mal, wenn es eine Ursache nennt:
   „Welche Beobachtung beweist das?“
5. **Die Historie durchgraben.** Bittet Claude, den Commit zu finden, der das Verhalten eingeführt
   hat, und anhand des Commits und seiner Message zu erklären, was der Autor wollte.
6. **Die Ursache benennen** in ein bis zwei Sätzen, mit Datei, Zeile und Commit. Listet dann jeden
   Code-Pfad auf, den dieselbe Ursache betrifft, nicht nur den aus dem Ticket.
7. **Mit Regressionstest fixen.** Schreibt zuerst den Test (in `api/test/`, Ausführung mit
   `npm test`) und seht ihn fehlschlagen, dann fixt, seht ihn bestehen und führt die ganze Suite
   aus. Prüft die zwei Reproduktionen des Tickets noch einmal von Hand.
8. Probiert mindestens einmal einen **Rubber-Duck**-Prompt: Beschreibt, was ihr getan, was ihr
   erwartet und was ihr beobachtet habt, und lasst Claude die Fragen stellen.

## Erfolgskriterien

**Feature**

- [ ] Beide Sätze des Tickets wurden reproduziert, einmal im Browser und einmal mit `curl` oder
      einem Test
- [ ] Claude hat anhand von Belegen gearbeitet: Hypothesen wurden getestet, nicht geraten
- [ ] Ihr habt den Commit gefunden, der das Verhalten eingeführt hat, und könnt die Absicht des
      Autors erklären
- [ ] Ihr könnt die Ursache und jeden Pfad nennen, den sie betrifft, nicht nur das Symptom

**App funktioniert weiterhin**

- [ ] Ein Regressionstest schlägt ohne euren Fix fehl und besteht mit ihm; `npm test` ist grün
- [ ] Die Reihe The Lord of the Rings lässt sich vorwärts und zurück navigieren, und das Speichern
      eines Buchs im Admin bricht keine Reihe mehr
- [ ] Bestehende Daten funktionieren nach eurem Fix weiterhin

## Referenzen

- Claude Code: Common workflows (fix bugs): https://code.claude.com/docs/en/common-workflows
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- Claude Code: Permission modes (plan mode): https://code.claude.com/docs/en/permission-modes
- Git: `git log -S` (pickaxe): https://git-scm.com/docs/git-log#Documentation/git-log.txt--Sltstringgt
- Git: `git blame`: https://git-scm.com/docs/git-blame
