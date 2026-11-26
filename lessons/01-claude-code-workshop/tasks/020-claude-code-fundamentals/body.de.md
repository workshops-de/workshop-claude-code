In dieser Aufgabe lernt ihr, wie Claude Code als **Agent** arbeitet: Es liest, sucht und führt Befehle aus, schaut sich das Ergebnis an und entscheidet dann den nächsten Schritt (**Reason → Act → Observe**). Ihr erbt eine fremde Codebasis und sollt sie nur **verstehen**. Ihr ändert keine Datei.

Die Codebasis ist [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy): eine Bibliotheks-App nach fünf Jahren und vier Entwicklern, Express-API auf SQLite, React-Web-App mit Vite, rund 15.000 Zeilen. Ihr braucht Claude Code, Git und ein Terminal. Ihr trefft sie in den Aufgaben zu Refactoring, Debugging und Code-Review wieder. Die Karte, die ihr heute zeichnet, hilft euch dort.

### 1. Klont das Repo und startet im Plan Mode

Im **Plan Mode** liest Claude Dateien und führt erkundende Befehle aus, ändert aber nichts, bis ihr einen Plan freigebt. In dieser Aufgabe gebt ihr nie einen frei.

**Im Terminal:**

```bash
git clone https://github.com/andrekovac/bookmonkey-legacy.git
cd bookmonkey-legacy
claude --permission-mode plan
```

Läuft schon eine Session, drückt `Shift+Tab`, bis `plan mode on` erscheint.

**In der Desktop-App (Tab „Code“):**

1. Klont das Repo einmal. Das geht in jedem Terminal oder im Terminal der App (``Ctrl+` ``):

   ```bash
   git clone https://github.com/andrekovac/bookmonkey-legacy.git
   ```

2. Startet eine neue Session und wählt unter dem Eingabefeld den Ordner `bookmonkey-legacy`.
3. Stellt im Modus-Menü daneben **Plan** ein.

### 2. Beobachtet die Schleife einmal

Führt `/context` aus und merkt euch den Wert. Fragt dann:

```text
Aus welchen Teilen besteht dieses Repository, und wie startet man jeden Teil?
```

Öffnet nach der Antwort mit `Ctrl+O` den Transcript-Viewer (Desktop-App: `Ctrl+O`, bis die Ansicht **Verbose** ist). Zählt die Tool-Aufrufe. Im Terminal schließt `Ctrl+O` den Viewer wieder. Sucht ein Wort aus dem Ergebnis eines Aufrufs in der Eingabe des nächsten: Das ist **Observe**, das den nächsten **Act** bestimmt. Den **Reason**-Schritt seht ihr nicht direkt, nur seine Wirkung auf den nächsten Aufruf.

### 3. Lasst euch die Architektur erklären

```text
Gib mir einen Überblick über die Architektur: Teile, Start, Ports, wo die Daten liegen. Nenn zu jeder Aussage die Datei, auf die sie sich stützt.
```

### 4. Lasst eine Abhängigkeitskarte zeichnen

```text
Zeichne die wichtigsten Module von API und Web-App als Mermaid-Diagramm, mit Pfeilen für die Imports.
```

Fügt es in [mermaid.live](https://mermaid.live) oder eine Mermaid-Vorschau im Editor ein. Prüft einen Pfeil selbst, indem ihr die Datei öffnet.

### 5. Verfolgt einen Request

```text
Wenn ich die Detailseite eines Buchs öffne: Welchen Weg nimmt der Request von der React-Seite über die API-Route und die Service-Schicht bis zur SQL-Abfrage? Mit Datei und Zeile.
```

### 6. Fragt nach den Risiken

```text
Was sind die fünf größten Risiken, wenn wir diese Codebasis übernehmen? Nenn zu jedem die Belege.
```

Hakt bei mindestens einem nach: „Zeig mir, wo“ oder „Stimmt das heute noch?“.

### 7. Fragt, wer woran gearbeitet hat

```text
Finde mit git log und git shortlog -sn heraus, wer welche Bereiche angefasst hat, in welchen Jahren, und wie sich der Stil verändert hat.
```

### 8. Prüft Kontextfenster und Repo

Führt `/context` noch einmal aus und vergleicht mit Schritt 2: Was hat das Fenster gefüllt? Prüft dann im Terminal `git status`: Es muss `nothing to commit, working tree clean` melden.

### Was gerade passiert ist

| Werkzeug | Wofür |
|---|---|
| Plan Mode | Erkunden, ohne dass etwas geändert wird |
| `Ctrl+O` | Sehen, was Claude wirklich gelesen und ausgeführt hat |
| `/context` | Sehen, wie voll das Kontextfenster ist |
| Artefakte verlangen | Diagramm, Datei und Zeile statt Eindruck: Das könnt ihr prüfen |

„Was hältst du von diesem Code?“ könnt ihr nicht prüfen. Ein Mermaid-Diagramm mit Dateien schon.

**Fertig, wenn** ihr Architekturüberblick, Abhängigkeitskarte, Request-Flow und fünf Risiken mit Belegen habt, sagen könnt, was das Kontextfenster gefüllt hat, sagen könnt, wann ihr eine vorgeschlagene Aktion freigebt und wann nicht, und `git status` sauber ist.

<details>
<summary>Mehr dazu</summary>

`/help` listet alle Slash Commands, `/permissions` zeigt, was Claude ohne Nachfrage tun darf. Docs: [Overview](https://code.claude.com/docs/en/overview), [Permission modes](https://code.claude.com/docs/en/permission-modes), [Common workflows](https://code.claude.com/docs/en/common-workflows), [Interactive mode](https://code.claude.com/docs/en/interactive-mode), [Commands](https://code.claude.com/docs/en/commands), [Mermaid](https://mermaid.js.org/syntax/flowchart.html).

</details>
