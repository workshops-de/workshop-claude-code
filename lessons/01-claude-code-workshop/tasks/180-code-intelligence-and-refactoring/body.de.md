## Überblick

Nutzt Claude Code für ein Refactoring, vor dem ein echtes Team zögern würde: groß, über viele
Dateien verteilt, in Code, den ihr nicht geschrieben habt. Ihr legt zuerst mit Tests fest, was der
Code heute tut, plant die Änderung im Plan Mode, lasst den Agenten die Hauptarbeit machen und
belegt, dass sich nichts geändert hat, was sich nicht ändern sollte. Refactoring mit einem Agenten
heißt: **Absicht, abgesichert durch ein Sicherheitsnetz**.

## Das Feature

Agenten glänzen bei Refactorings, die Verständnis und Urteilsvermögen brauchen: ein verworrenes
Modul umstrukturieren, ein Muster an vielen Aufrufstellen anwenden, jede Stelle finden, die
dasselbe leicht anders macht. Sie sind _nicht_ das schnellste Werkzeug für mechanische Änderungen,
die eure IDE sofort erledigt (ein Symbol umbenennen, eine Methode extrahieren).

- **Zuerst Characterisation-Tests.** Bevor ihr die Struktur ändert, lasst Claude Tests schreiben,
  die festhalten, was der Code _heute_ tut, richtig oder falsch, über die öffentliche Schnittstelle
  (HTTP-Endpoints, exportierte Funktionen). Sie müssen vor und nach dem Refactoring bestehen.
- **Plan Mode für die Änderung** (`claude --permission-mode plan` oder `Shift+Tab`): Lasst euch ein
  Inventar aller betroffenen Stellen geben, eine Schrittreihenfolge, bei der die Tests nach jedem
  Schritt grün bleiben, und eine Liste der Risiken. Widersprecht, bevor sich eine Datei ändert.
- **Kleine, geprüfte Schritte.** Lasst Claude nach jedem Schritt die Tests ausführen und bei Grün
  committen, damit ein Fehltritt einen Schritt kostet und nicht den Nachmittag. Lest jeden Schritt
  mit `/diff`; `/rewind` und git sind euer Undo. `/rewind` holt keine Dateien zurück, die nur Bash
  geändert hat (ein `mv`): Dafür nutzt ihr git.
- **Code Intelligence (optional).** Ein Language-Server-Plugin gibt Claude Go-to-Definition und
  Find-References statt grep (siehe Bonus).

## Anwendung auf BookMonkey Legacy

> **Repo / Ports:** euer `bookmonkey-legacy`-Clone (Node.js 24 oder neuer), API auf
> http://localhost:4780, Web-App auf http://localhost:5180
>
> **Login:** Admin `admin@bookmonkey.example` / `admin2021`

Das Übungsfeld ist euer Clone von [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy).
Der Product Owner hat zwei Wünsche auf dem Board. Wählt **einen**:

- **(a) „Preise müssen überall konsistent sein.“** Jede Stelle, die einen Preis anzeigt, summiert,
  speichert oder exportiert, läuft über einen einzigen Preis-Pfad. Der Kunde sieht für dasselbe
  Buch auf jedem Screen, im Warenkorb, an der Kasse und in Exporten denselben Preis. Wie Preise
  dargestellt werden, entscheidet ihr im Plan Mode.
  **In dieser Aufgabe:** Wählt drei Stellen, an denen ein Preis auftaucht, und deckt diese ab. Der
  Rest ist Bonus, falls noch Zeit bleibt.
- **(b) „Die große v1-Routes-Datei nach Ressourcen aufteilen, ohne das Verhalten zu ändern.“**
  `api/routes.js` wird zu einer Datei pro Ressource, nach dem Muster, das `api/routes/` schon
  begonnen hat. Jeder Endpoint antwortet exakt wie zuvor: gleiche Statuscodes, gleiche Bodies,
  gleiche Zugriffsregeln.
  **In dieser Aufgabe:** Verschiebt zuerst zwei Ressourcen, zum Beispiel Bücher und Warenkorb. Der
  Rest kann später nach demselben Muster folgen.

Euer Team erlaubt es? Dann dürft ihr stattdessen einen Teil eurer **eigenen Codebasis**
refaktorieren, mit denselben Schritten: Characterisation-Tests, Plan, kleine geprüfte Schritte.

Kein echtes Refactoring ist in einer Stunde fertig. **Ein sauberer Teilschritt mit grünen Tests
gilt als Erfolg**: Genau diesen Stand würde ein echtes Team mergen und morgen weiterführen.

## Voraussetzungen

- Der `bookmonkey-legacy`-Clone mit durchgeführtem `npm install` und `npm run db:reset` sowie eure
  `CLAUDE.md` aus der CLAUDE.md-Aufgabe
- Ein Branch für die Arbeit: `git switch -c refactor/prices` oder `git switch -c refactor/split-routes`

## Schritte

1. **Das Gelände kartieren** im Plan Mode. Für (a): jede Stelle, die einen Preis berechnet,
   anzeigt, summiert, speichert oder exportiert, in der API und in der Web-App. Für (b): jeder
   Endpoint in `api/routes.js`, gruppiert nach Ressource, mit der Middleware, die für ihn gilt.
   Lasst euch zu jedem Eintrag Datei und Zeile nennen.
2. **Characterisation-Tests schreiben** für das, was ihr anfassen wollt, mit dem vorhandenen
   `node:test`-Setup in `api/test/` (Ausführung mit `npm test`). Für (a): was die drei gewählten
   Stellen heute für ein paar Bücher anzeigen. Für (b): Statuscode und Antwortform jedes Endpoints
   der zwei Ressourcen, die ihr zuerst verschiebt, einschließlich der Fehlerfälle. Committet die
   Tests, solange sie grün sind.
3. **Das Refactoring planen.** Lasst euch einen Plan mit Schritten geben, die jeweils `npm test`
   grün halten, und widersprecht mindestens einmal (ein Schritt, der zu groß ist, eine übersehene
   Stelle, ein Verhalten, das er nebenbei „reparieren“ will). Bearbeitet den Plan bei Bedarf mit
   `Ctrl+G`.
4. **Schritt für Schritt ausführen.** Gebt den Plan frei, lasst Claude nach jedem Schritt die Tests
   ausführen, lest mit `/diff`, was der Schritt geändert hat, und committet nach jedem grünen
   Schritt. Schlägt ein Test fehl, haltet an und entscheidet: Fehler im Refactoring, oder hat der
   Test etwas Falsches festgehalten? Bei einem Fehltritt geht mit `/rewind` (oder zweimal `Esc`)
   zum letzten guten Checkpoint zurück, statt vorwärts zu flicken.
5. **Prüfen** über die Tests hinaus: Lest den kompletten Diff (`git diff main --stat`, dann die
   Dateien), startet beide Dev-Server und seht euch ein paar Seiten im Browser an. Für (a)
   vergleicht den Preis desselben Buchs in der Liste, auf der Detailseite und im Export. Für (b)
   klickt euch durch die Seiten, die die zwei verschobenen Ressourcen nutzen.
6. Probiert nun eine bewusst **mechanische** Änderung (einen Helper umbenennen, eine Funktion
   verschieben) einmal mit Claude und einmal mit eurer IDE und achtet darauf, was schneller geht.
7. Reflektiert: Wo hat sich das Verständnis des Agenten ausgezahlt, und wo haben die Tests ihn
   erwischt?

## Erfolgskriterien

**Feature**

- [ ] Characterisation-Tests existierten und bestanden **vor** der ersten strukturellen Änderung
- [ ] Das Refactoring wurde im Plan Mode geplant, und der Plan hat sich mindestens einmal
      geändert, weil ihr widersprochen habt
- [ ] Die Arbeit landete als mehrere kleine Commits, jeweils mit grünen Tests, und ihr habt nach
      jedem Schritt `/diff` gelesen
- [ ] Ihr habt mindestens einmal `/rewind` (oder einen `git`-Reset) genutzt oder könnt sagen, wann
      ihr es tun würdet
- [ ] Ihr habt mindestens eine mechanische Änderung gefunden, die in der IDE schneller war

**App funktioniert weiterhin**

- [ ] `npm test` besteht, einschließlich eurer neuen Tests
- [ ] Für (a): Ein Buch zeigt in der Liste, auf der Detailseite und im Export denselben Preis
      (auch im Warenkorb und an der Kasse, falls ihr den Bonus gemacht habt); für (b): Die zwei
      verschobenen Ressourcen liegen in eigenen Dateien, und ihre Endpoints verhalten sich wie
      zuvor
- [ ] Wenn ihr früh aufgehört habt, ist der letzte Commit ein sauberer Teilschritt mit grünen Tests
- [ ] Verhalten, das falsch aussah, aber nicht Teil des Wunsches war, ist aufgeschrieben und nicht
      stillschweigend geändert

## Referenzen

- Claude Code: Common workflows (refactor code): https://code.claude.com/docs/en/common-workflows
- Claude Code: Best practices: https://code.claude.com/docs/en/best-practices
- Claude Code: Checkpointing (`/rewind`): https://code.claude.com/docs/en/checkpointing
- Michael Feathers: Characterization testing: https://michaelfeathers.silvrback.com/characterization-testing
- Refactoring catalogue (Martin Fowler): https://refactoring.com/catalog/
