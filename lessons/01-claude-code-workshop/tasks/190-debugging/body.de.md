> **⚠️ Setup zuerst, im `bookmonkey-legacy`-Clone:** Schickt diesen Prompt an Claude. In der Desktop-App startet Claude die Server in eigenen Terminal-Tabs (stoppen: Ctrl+C im Tab). Ohne Desktop-App nennt Claude euch die Befehle.
>
> ```text
> Setup für Aufgabe 190: Wechsle auf den Branch main. Gibt es offene Änderungen, frag mich vorher. Steht in .claude/settings.local.json noch der Stop-Hook aus Aufgabe 180, entferne ihn. Läuft auf Port 4780 schon eine API, beende sie. Führe dann npm run db:reset aus, damit die Daten frisch sind. Prüf mit curl, ob die API auf http://localhost:4780 (Befehl: npm run dev:api) und die Web-App auf http://localhost:5180 (Befehl: npm run dev:web) antworten. Fehlt ein Server, starte ihn mit diesem Befehl in einem eigenen Tab im Terminal der Desktop-App. Geht das nicht, nenn mir die Befehle. Ist ein Port schon belegt, frag mich. Gib mir am Ende eine Checkliste mit ✅ und ❌.
> ```

---

In dieser Aufgabe geht es um **Debugging mit Claude**: Ihr bekommt ein Fehlerticket von Nutzern und arbeitet euch mit Belegen statt Vermutungen bis zur Ursache vor. Ihr arbeitet in eurem `bookmonkey-legacy`-Clone mit Node.js 24 oder neuer.

Das ist das Ticket, mehr wisst ihr nicht:

> **Ticket #412: „Nächster Band“ führt ins Nichts**
>
> Seit einer Weile führt der Link „nächster Band“ bei The Lord of the Rings ins Nichts. Andere Reihen funktionieren, bis jemand im Admin ein Buch speichert.

### 1. Repliziert den Fehler selbst

Öffnet http://localhost:5180 und im Katalog „The Fellowship of the Ring“. Unten auf der Seite steht ein Kasten zur Reihe mit dem Link zum nächsten Band. Bei uns stand dort „Nächster Band »: nicht gefunden“.

Meldet euch dann unter http://localhost:5180/login mit `admin@bookmonkey.example` und `admin2021` an. Öffnet http://localhost:5180/admin/books, wählt „A Game of Thrones“, tragt im Feld „Untertitel“ ein x ein und klickt auf „Speichern“. Schaut euch danach die anderen Bände dieser Reihe im Katalog an.

### 2. Lasst Claude Hypothesen prüfen, ohne etwas zu ändern

Startet eine neue Session im Modus **Auto** und bleibt bis zum Ende darin. Eine Hypothese ist eine Vermutung, die sich prüfen lässt. Ihr wollt mehrere davon, bevor Claude Code anfasst:

```text
Ticket #412 vom Bibliotheksteam: Der Link "nächster Band" bei The Lord of the Rings führt ins Nichts. Andere Reihen funktionieren, bis jemand im Admin ein Buch speichert.

Das habe ich beobachtet: Auf der Seite von The Fellowship of the Ring steht "Nächster Band: nicht gefunden". Nachdem ich A Game of Thrones im Admin gespeichert habe, funktioniert die Navigation in dieser Reihe nicht mehr.

Finde die Ursache, bevor du etwas änderst. Stell zwei oder drei Hypothesen auf, die beide Beobachtungen erklären könnten, und prüf jede mit einem schnellen Check. Sag mir zu jeder Ursache, welche Beobachtung sie belegt. Ändere noch keinen Code.
```

Prüft die Antwort: Hat jede Ursache einen Beleg? Eine Ursache ohne Beleg ist nur eine Vermutung.

### 3. Lasst alle Stellen beheben, mit Test zuerst

```text
Nenne die Ursache mit Datei und Zeile und liste jede Stelle im Code, die davon betroffen ist, nicht nur die aus dem Ticket. Ändere noch nichts.
```

Zählt die Stellen: Sind es mehr als die eine aus dem Ticket? Dann:

```text
Schreib zuerst einen Test in api/test/, der den Fehler zeigt, und zeig mir, dass er fehlschlägt. Behebe danach die Ursache an allen Stellen aus deiner Liste und lass npm test laufen. Lies vor dem Commit den Diff und committe, wenn alles grün ist.
```

Achtet darauf, dass der Test zuerst rot war. Rot vor dem Fix und grün danach beweist, dass der Fix wirkt.

### 4. Prüft es selbst

Beendet die API mit Ctrl+C, führt `npm run db:reset` aus, startet sie mit `npm run dev:api` neu und wiederholt Schritt 1 im Browser, auch das Speichern im Admin.

### Was gerade passiert ist

Ihr habt Claude eine Strategie mitgegeben statt nur das Ticket: erst replizieren, dann Hypothesen mit Belegen, dann alle betroffenen Stellen, dann ein roter Test. Ein Fix nur an der Stelle aus dem Ticket würde das Symptom verstecken, und die Ursache bliebe. Deshalb fragt ihr in Schritt 3 nach allen Stellen.

**Fertig, wenn** der Link „nächster Band“ bei The Fellowship of the Ring funktioniert, das Speichern eines Buchs im Admin keine Reihe mehr kaputt macht, ein neuer Test den Fehler abdeckt, `npm test` grün ist und alles committet ist.

<details>
<summary>Mehr dazu</summary>

- Beginnt ihr zwischendurch eine neue Session, fehlt Claude der Verlauf. Gebt dann Ticket und Beobachtungen noch einmal mit.
- Die Antworten von Claude unterscheiden sich von Lauf zu Lauf. Prüft eine Aussage, indem ihr den Check selbst ausführt.
- Zeit übrig? Fragt die Git-Historie: „Finde heraus, wann dieses Verhalten in den Code gekommen ist, und erkläre mit der Commit-Nachricht, was der Autor damals erreichen wollte.“ Oft zeigt das, warum der Code so gebaut wurde.
- [Common workflows: Fix bugs](https://code.claude.com/docs/en/common-workflows) · [Best practices](https://code.claude.com/docs/en/best-practices) · [Permission modes](https://code.claude.com/docs/en/permission-modes)

</details>
