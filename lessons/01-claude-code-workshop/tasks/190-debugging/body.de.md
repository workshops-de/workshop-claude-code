> **⚠️ Vorher starten, im `bookmonkey-legacy`-Clone:** jeweils in einem eigenen Terminal, während der ganzen Aufgabe offen lassen.
> - API: `npm run dev:api` (http://localhost:4780)
> - Web-App: `npm run dev:web` (http://localhost:5180)
> - Davor, falls ihr unsicher seid, ob die Daten frisch sind: `npm run db:reset`

In dieser Aufgabe geht es um **Debugging mit Claude**: Ihr bekommt ein Fehlerticket von Nutzern und arbeitet euch mit Belegen statt Vermutungen bis zur Ursache vor. Ihr arbeitet in eurem `bookmonkey-legacy`-Clone mit Node.js 24 oder neuer.

Das ist das Ticket, mehr wisst ihr nicht:

> **Ticket #412: „Nächster Band“ führt ins Nichts**
>
> Seit einer Weile führt der Link „nächster Band“ bei The Lord of the Rings ins Nichts. Andere Reihen funktionieren, bis jemand im Admin ein Buch speichert.

### 1. Seht den ersten Satz selbst

Öffnet http://localhost:5180 und im Katalog „The Fellowship of the Ring“. Auf der Seite des Buchs gibt es unten einen Kasten zur Reihe mit dem Link zum nächsten Band. Bei uns stand dort „Nächster Band »: nicht gefunden“.

### 2. Seht den zweiten Satz selbst

Meldet euch unter http://localhost:5180/login mit `admin@bookmonkey.example` und `admin2021` an. Öffnet http://localhost:5180/admin/books, wählt „A Game of Thrones“, tragt im Feld „Untertitel“ ein x ein und klickt auf „Speichern“. Schaut euch danach die anderen Bände dieser Reihe im Katalog an.

### 3. Gebt Claude die Belege

Startet eine neue Session und stellt den Modus auf **Plan**. Bleibt für die Schritte 3 bis 8 in dieser Session. Eine Hypothese ist eine Vermutung, die sich prüfen lässt. Ihr wollt mehrere davon, bevor Claude Code anfasst:

```text
Ticket #412 vom Bibliotheksteam: Der Link "nächster Band" bei The Lord of the Rings führt ins Nichts. Andere Reihen funktionieren, bis jemand im Admin ein Buch speichert.

Das habe ich beobachtet: Auf der Seite von The Fellowship of the Ring steht "Nächster Band: nicht gefunden". Nachdem ich A Game of Thrones im Admin gespeichert habe, funktioniert die Navigation in dieser Reihe nicht mehr.

Nenne zwei oder drei konkurrierende Hypothesen, die beide Beobachtungen erklären könnten, und für jede einen günstigen Check. Ändere nichts.
```

Claude liest den Code und liefert Hypothesen mit Checks. In unserem Lauf hat es nur gelesen und nichts geändert.

### 4. Lasst die Checks laufen

Stellt den Modus auf Auto, damit Claude die Checks ausführen darf:

```text
Führe die Checks jetzt aus. Ändere noch keinen Code. Zu jeder Ursache, die du nennst: Welche Beobachtung belegt sie, und welche schließt eine andere Hypothese aus?
```

Claude fragt die API ab und vergleicht Daten. Mit der Frage nach der Beobachtung bekommt ihr zu jeder Ursache einen Beleg. Eine Ursache ohne Beleg ist nur eine Vermutung.

### 5. Fragt die Git-Historie

```text
Finde mit der Git-Historie heraus, wann dieses Verhalten in den Code gekommen ist. Nenne den Commit, lies seine Nachricht und erkläre, was der Autor damals erreichen wollte.
```

Eine Commit-Nachricht und der Code drumherum verraten oft, was der Autor erreichen wollte.

### 6. Fragt nach der Ursache und allen betroffenen Stellen

Schreibt den Prompt selbst. Ihr wollt erreichen: die Ursache in ein bis zwei Sätzen mit Datei und Zeile, dazu jede Stelle im Code, die davon betroffen ist, nicht nur die aus dem Ticket. Claude soll noch nichts ändern.

Zum Beispiel:

```text
Nenne die Ursache in ein bis zwei Sätzen mit Datei und Zeile. Liste danach jede Stelle im Code, die von derselben Ursache betroffen ist, nicht nur die aus dem Ticket. Ändere noch nichts.
```

### 7. Behebt sie mit einem Test

```text
Schreibe zuerst einen Test in api/test/, der den Fehler aus dem Ticket zeigt, und führe ihn aus. Er muss fehlschlagen. Behebe dann die Ursache an allen Stellen aus deiner Liste. Führe danach alle Tests mit npm test aus.
```

Claude schreibt den Test, zeigt ihn rot, behebt den Fehler und zeigt ihn grün. Beendet danach die API mit Ctrl+C, führt `npm run db:reset` aus, startet sie mit `npm run dev:api` neu und wiederholt Schritt 1 und 2 im Browser.

### 8. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

Ihr habt einen Fehler nicht geraten, sondern belegt: erst reproduziert, dann Hypothesen geprüft, dann die Historie gelesen. Der Test, der vor dem Fix rot war und danach grün, beweist, dass der Fix wirkt. Ein Fix nur an der Stelle aus dem Ticket würde dagegen das Symptom verstecken. Deshalb habt ihr in Schritt 6 nach allen betroffenen Stellen gefragt.

**Fertig, wenn** der Link „nächster Band“ bei The Fellowship of the Ring funktioniert, das Speichern eines Buchs im Admin keine Reihe mehr kaputt macht, ein neuer Test den Fehler abdeckt, `npm test` grün ist und alles committet ist.

<details>
<summary>Mehr dazu</summary>

- Beginnt ihr zwischendurch eine neue Session, fehlt Claude der Verlauf. Gebt dann Ticket und Beobachtungen noch einmal mit.
- Die Antworten von Claude unterscheiden sich von Lauf zu Lauf. Prüft eine Aussage, indem ihr den Check selbst ausführt.
- [Common workflows: Fix bugs](https://code.claude.com/docs/en/common-workflows) · [Best practices](https://code.claude.com/docs/en/best-practices) · [Permission modes](https://code.claude.com/docs/en/permission-modes)

</details>
