> **✅ Kein Server nötig:** Für diese Aufgabe müsst ihr vorher nichts starten.

In dieser Aufgabe geht es um die **BMAD Method**. Sie liefert euch Skills, mit denen ihr eine Idee in festen Schritten (Brief, Anforderungen, Architektur, Umsetzung) plant und baut, und jeder Schritt hat eine eigene Rolle mit Namen. Ihr baut eine kleine, neue Packlisten-App.

Ihr arbeitet in einem **neuen, leeren Ordner** mit Node.js 22 oder neuer.

### 1. Installiert BMAD

Legt den Ordner an, öffnet ihn in der Desktop-App und öffnet dort das Terminal:

```text
git init
npx bmad-method@6.12.4 install
```

Wählt im Installer **Claude Code** als Tool und das Modul **BMad Method**. Den Rest bestätigt ihr mit den Vorgaben. Danach liegen im Ordner `.claude/skills` die BMAD-Skills und in `_bmad` die Konfiguration. Startet dann eine neue Session in diesem Ordner, damit die Skills geladen sind.

### 2. Fragt die Hilfe

```text
/bmad-help Ich habe eine neue Idee: eine Packlisten-App. Was ist der erste Schritt?
```

Die Hilfe schaut in den Ordner, sieht, dass noch nichts existiert, und empfiehlt den nächsten Skill. In unserem Lauf war das das Brief, mit der Reihenfolge Brief, PRD, Architektur, Epics und Stories, Build.

### 3. Schreibt das Product Brief

```text
/bmad-product-brief Eine wiederverwendbare Packlisten-App: Vorlagen, aus Vorlagen erzeugte Reisen, Abhak-Fortschritt. Läuft lokal im Browser.
```

Der Skill stellt euch Fragen, zum Beispiel wer die App nutzt und was sie können muss. Antwortet kurz und mit eigenen Worten, ausgedachte Angaben reichen. Wisst ihr etwas nicht, sagt "Entscheide du". Am Ende liegt ein Brief in `_bmad-output/planning-artifacts/briefs/`.

Ab hier haben wir den Ablauf nicht selbst durchgespielt, die Skills gibt es in Version 6.12.4.

### 4. Macht daraus das PRD

Das PRD (Product Requirements Document) hält fest, was die App können muss. Startet für diesen Schritt eine neue Session.

```text
/bmad-prd Erstelle das PRD aus dem Brief in _bmad-output/planning-artifacts/briefs/.
```

### 5. Legt die Architektur fest

Auch hier eine neue Session. Der Skill hält die Entscheidungen fest, die später alle Teile der App konsistent halten.

```text
/bmad-architecture Erstelle die Architektur zum PRD in _bmad-output/planning-artifacts/.
```

### 6. Plant und baut selbst

Fragt `/bmad-help`, was nach der Architektur kommt, und führt die genannten Skills in dieser Reihenfolge aus, jeden in einer neuen Session. Sagt dem Entwickler (der Rolle Amelia) dann, was sie bauen soll. Ihr schreibt den Prompt selbst und wollt erreichen, dass die erste Story umgesetzt ist und die App im Browser läuft.

Zum Beispiel:

```text
/bmad-build Setze die erste Story aus den Epics um. Starte die App mit npm run dev auf Port 3440 und sag mir, was ich im Browser prüfen kann.
```

### 7. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

BMAD besteht aus **Skills**, die jeweils einen Schritt führen und ein Dokument in `_bmad-output` ablegen. Das nächste Dokument baut auf dem vorigen auf. Deshalb dürft ihr zwischen den Schritten neue Sessions starten: Das Wissen liegt in den Dateien. Die Rollen heißen in der Installation Mary (Analyst), John (Product Manager), Winston (Architekt) und Amelia (Entwicklerin).

**Fertig, wenn** BMAD installiert ist, Brief, PRD und Architektur als Dateien in `_bmad-output` liegen die erste Story umgesetzt ist und die App im Browser läuft.

<details>
<summary>Mehr dazu</summary>

Die Skills `bmad-party-mode` (mehrere Rollen diskutieren eine Entscheidung) und `bmad-qa-generate-e2e-tests` (erzeugt API- und End-to-End-Tests) gibt es auch. Probiert sie aus, wenn Zeit bleibt. Mit `--yes --tools claude-code --modules bmm` läuft der Installer ohne Rückfragen.

[BMAD Method, Version 6.12](https://github.com/bmad-code-org/BMAD-METHOD/tree/V6.12)

</details>
