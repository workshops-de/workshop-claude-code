## Überblick

Lernt, Claude Code als agentisches Tool auf einer Codebasis zu steuern, die ihr noch nie gesehen
habt. Ihr erbt eine echte, gewachsene Anwendung und habt nur eine Aufgabe: sie zu **verstehen**.
Ihr ändert keine Datei. Dabei lernt ihr das mentale Modell hinter dem Tool: Ein Agent arbeitet in
einer **Reason → Act → Observe**-Schleife, schlägt Tool-Aufrufe vor, die eure Umgebung verändern,
und ist nur so gut wie der Kontext, den ihr ihm gebt.

In dieser Aufgabe erzeugt ihr **keinen** Code. Ihr erzeugt Verständnis und Routine im Umgang mit
dem Tool.

## Das Feature

Claude Code liest, durchsucht und führt Befehle in eurem Repository aus und überlegt dann, was es
gesehen hat. Zum Erkunden wollt ihr all das, nur ohne Änderungen:

- **Plan Mode ist schreibgeschützt.** Startet eine Session darin mit
  `claude --permission-mode plan` oder drückt `Shift+Tab`, bis die Statuszeile `plan mode on`
  zeigt. Claude liest Dateien und führt erkundende Shell-Befehle aus, Änderungen bleiben aber
  gesperrt, bis ihr einen Plan freigebt. In dieser Aufgabe gebt ihr nie einen frei.
- **Beobachtet die Schleife.** Jeder Tool-Aufruf (Read, Grep, ein `git log`) ist ein _Act_; seine
  Ausgabe ist der _Observe_-Schritt; der nächste Satz ist der _Reason_-Schritt. Öffnet den
  Transcript-Viewer mit `Ctrl+O`, um zu sehen, was Claude sich tatsächlich angeschaut hat.
- **Slash Commands** steuern die Session: `/help` listet sie auf, `/context` zeigt, wie voll das
  Kontextfenster ist, `/permissions` zeigt, was Claude ohne Nachfrage tun darf.
- **Verlangt Artefakte, keine Eindrücke.** „Zeichne ein Mermaid-Diagramm der Module und ihrer
  Imports“ ist überprüfbar. „Was hältst du von diesem Code?“ ist es nicht.

## Anwendung auf BookMonkey Legacy

> **Repo / Ports:** euer `bookmonkey-legacy`-Clone (Node.js 24 oder neuer), API auf
> http://localhost:4780, Web-App auf http://localhost:5180
>
> **Login:** Admin `admin@bookmonkey.example` / `admin2021`

In den Build-Aufgaben erstellt ihr einen frischen BookMonkey. Hier lernt ihr seinen älteren
Bruder kennen: [`bookmonkey-legacy`](https://github.com/andrekovac/bookmonkey-legacy), die
Bibliotheks- und Buchshop-App eines Unternehmens, wie sie nach fünf Jahren und vier Entwicklern
aussieht: eine Express-API auf SQLite, eine React-Web-App mit Vite, rund 15.000 Zeilen Code, die
Feature für Feature gewachsen sind, und die passende Git-Historie dazu. Diese Codebasis erbt ihr
in den Aufgaben zu Refactoring, Debugging und Code-Review noch einmal, die Karte, die ihr heute
zeichnet, zahlt sich also später aus.

## Voraussetzungen

- Claude Code installiert und geprüft (siehe „Claude Code installieren und prüfen“)
- Git und ein Terminal. Node.js 24 oder neuer nur, wenn ihr die App starten wollt (hier optional).

## Schritte

1. Klont das Repository und startet Claude Code darin im Plan Mode:

   ```bash
   git clone https://github.com/andrekovac/bookmonkey-legacy.git
   cd bookmonkey-legacy
   claude --permission-mode plan
   ```

2. **Beobachtet die Schleife einmal.** Führt `/context` aus, damit ihr eine Ausgangsbasis habt.
   Stellt dann eine erste Architekturfrage, zum Beispiel „Aus welchen Teilen besteht dieses
   Repository, und wie wird jeder gestartet?“. Wenn die Antwort da ist, drückt `Ctrl+O`, um den
   Transcript-Viewer zu öffnen, und zählt die Tool-Aufrufe, die Claude gemacht hat. Wählt einen
   Aufruf und benennt seine drei Schritte: **Reason** (warum Claude ihn gewählt hat), **Act** (der
   Aufruf selbst), **Observe** (was zurückkam und wie der nächste Schritt es genutzt hat). Mit
   `Ctrl+O` schließt ihr den Viewer wieder.
3. Verlangt einen **Architekturüberblick**: die Teile des Systems, wie sie gestartet werden,
   welche Ports sie nutzen und wo die Daten liegen. Claude soll zu jeder Aussage die Dateien
   nennen, auf die sie sich stützt.
4. Verlangt eine **Abhängigkeitskarte** als Mermaid-Diagramm: die wichtigsten Module der API und
   der Web-App und welches welches importiert. Fügt sie in eine Mermaid-Vorschau ein (euer Editor
   oder [mermaid.live](https://mermaid.live)) und prüft einen Pfeil selbst, indem ihr die Datei
   öffnet.
5. Wählt eine Nutzeraktion, zum Beispiel „die Detailseite eines Buchs öffnen“, und lasst Claude
   den **Request-Flow** von der React-Seite über die API-Route und die Service-Schicht bis zur
   SQL-Abfrage nachverfolgen, mit Datei- und Zeilenangaben.
6. Verlangt die **fünf größten Risiken** bei der Übernahme dieser Codebasis, jeweils mit den
   Belegen, aus denen Claude sie gewählt hat. Hakt bei mindestens einem nach: „zeig mir, wo“,
   „stimmt das heute noch?“.
7. Fragt, **wer woran gearbeitet hat**: Claude soll mit `git log` und `git shortlog -sn`
   herausfinden, welche Entwickler welche Bereiche angefasst haben, in welchen Jahren und wie sich
   der Stil über die Zeit verändert hat.
8. Führt `/context` noch einmal aus und vergleicht mit eurer Ausgangsbasis. Prüft dann das
   Repository: `git status` muss `nothing to commit, working tree clean` melden.

## Erfolgskriterien

**Feature**

- [ ] Ihr habt die ganze Session im Plan Mode erkundet und nie einen Plan freigegeben
- [ ] Ihr könnt einen Reason → Act → Observe-Zyklus aus eurer Session beschreiben, samt Tool-Aufruf
- [ ] Ihr habt `/context` am Anfang und am Ende geprüft und wisst, was das Fenster gefüllt hat
- [ ] Ihr könnt erklären, wann ihr eine vorgeschlagene Aktion freigebt und wann ihr sie ablehnt

**Codebasis verstanden, nichts geändert**

- [ ] Ihr habt einen Architekturüberblick, eine Mermaid-Abhängigkeitskarte und einen
      nachverfolgten Request-Flow, jeweils mit Dateiverweisen
- [ ] Ihr habt fünf Risiken mit Belegen und mindestens eines davon hinterfragt
- [ ] Ihr wisst, wer wann an welchem Teil des Codes gearbeitet hat
- [ ] `git status` in `bookmonkey-legacy` ist sauber

## Referenzen

- Claude Code: Overview: https://code.claude.com/docs/en/overview
- Claude Code: Permission modes (plan mode): https://code.claude.com/docs/en/permission-modes
- Claude Code: Common workflows (understand new codebases): https://code.claude.com/docs/en/common-workflows
- Claude Code: Interactive mode: https://code.claude.com/docs/en/interactive-mode
- Claude Code: Commands: https://code.claude.com/docs/en/commands
- Mermaid flowchart syntax: https://mermaid.js.org/syntax/flowchart.html
