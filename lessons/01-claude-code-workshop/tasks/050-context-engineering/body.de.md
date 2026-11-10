In dieser Aufgabe geht es um das **Kontextfenster**: Alles, was Claude in einer Session liest, bleibt darin und belegt Platz. Ihr füllt es absichtlich, **kompaktiert** es und startet danach mit einer **neuen Session** neu.

Ihr arbeitet in eurem `bookmonkey-legacy`-Clone (Node.js 24). Hat das Projekt noch keine `CLAUDE.md`, schreibt in einer Session `/init`.

### 1. Stellt eine Frage, die ihr später prüfen könnt

```text
Welche Datei und Funktion verlängern eine Ausleihe, und wie lauten die Verlängerungsregeln? Antworte kurz.
```

Claude nennt eine Funktion mit Zeilenangabe und die Regeln. Kopiert die Antwort, sie ist euer Vergleichswert.

### 2. Verschmutzt die Session

Bleibt in derselben Session und gebt Claude viel Lesestoff:

```text
Lies api/routes.js komplett mit dem Read-Tool und fasse jeden Abschnitt in zwei Sätzen zusammen.
```

```text
Lies jetzt api/seed/books.json und danach jede Datei unter api/services, api/lib und api/test mit dem Read-Tool. Sag mir nur, wie viele Dateien du gelesen hast.
```

In unserem Lauf waren das rund 40 Dateien. Die Session ist jetzt deutlich größer als nach Schritt 1.

### 3. Fragt noch einmal

```text
Welche Datei und Funktion verlängern eine Ausleihe, und wie lauten die Verlängerungsregeln? Antworte kurz. Und: Welche Zeilen von api/routes.js gehören zur Route POST /loans/:id/renew?
```

Vergleicht mit Schritt 1. In unseren Läufen blieb die Antwort richtig, die Session war nur viel größer. Fehler zeigen sich eher später, bei noch längeren Sessions.

### 4. Kompaktiert

```text
/compact Behalte die Verlängerungsregeln für Ausleihen und die Dateien, in denen sie stehen.
```

Claude fasst das Gespräch zusammen und macht mit der Zusammenfassung weiter. Fragt danach, was nur im Gespräch stand, zum Beispiel: `Wie viele Dateien hast du vorhin unter api/test gelesen?` Prüft die Antwort mit `ls api/test`. In einem Lauf nannte Claude vorher eine falsche Zahl und danach die richtige, das kann bei euch anders sein. Ihr seht also, was die Zusammenfassung behält, und müsst Details nachprüfen.

### 5. Startet neu

Startet eine **neue Session** für eine Aufgabe, die mit der alten nichts zu tun hat:

```text
Erkläre kurz das Routing der Web-App.
```

Die neue Session beginnt ohne den alten Lesestoff.

### 6. Haltet das Lesen aus eurer Session heraus

Schreibt selbst einen Prompt: Claude soll alle Migrationsdateien in `api/migrations` durchgehen und euch pro Datei eine Zeile liefern, ohne dass der ganze Inhalt in eurer Session landet.

### Was gerade passiert ist

| Hebel | Wann |
|---|---|
| `/compact` mit Fokus | Dieselbe Aufgabe läuft weiter, das Fenster wird voll |
| Neue Session | Die nächste Aufgabe ist unabhängig |
| Subagent | Viel lesen, wenig Ergebnis |

Ein Subagent liest in seinem eigenen Kontext und gibt nur die Antwort zurück. In unserem Lauf lieferte er eine Tabelle mit einer Zeile pro Migration.

**Fertig, wenn** ihr die Session verschmutzt, kompaktiert und neu gestartet habt und für jeden Hebel sagen könnt, wann ihr ihn nutzt.

<details>
<summary>Mehr dazu</summary>

Den Füllstand zeigt `/context` (wir haben es hier nicht getestet, siehe Docs). `/btw` stellt eine Zwischenfrage, ohne sie dem Gespräch hinzuzufügen. Mehr in den Docs: [Commands](https://code.claude.com/docs/en/commands), [Costs and context usage](https://code.claude.com/docs/en/costs), [Best practices](https://code.claude.com/docs/en/best-practices).

</details>
