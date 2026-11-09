## Überblick

Erlebt die **BMAD Method** – ein Team spezialisierter Agent-Personas, die einen moderierten agilen
Workflow durchlaufen – indem ihr ein Briefing von der Idee zu einer funktionierenden Anwendung
bringt. Das steht im Gegensatz sowohl zu Ad-hoc-Prompting als auch zum Spec-zentrierten Ablauf von
Spec Kit.

## Hintergrund

BMAD („Breakthrough Method for Agile AI-Driven Development“) liefert spezialisierte Agenten
(Analyst, Product Manager, Architekt, Entwickler, UX-Designer) sowie moderierte Workflows, die die
Planungstiefe an die Komplexität des Projekts anpassen. Ein „Party Mode“ holt mehrere Personas in
eine Session, um Trade-offs aufzulösen. Baut hier eine **neue, kleine Anwendung**. Vorgeschlagenes
Briefing: eine wiederverwendbare Packlisten-App (Vorlagen, aus Vorlagen erzeugte Reisen,
Abhak-Fortschritt).

## Schritte

1. Installiert BMAD (`npx bmad-method install`, im Test v6.12) und wählt Claude Code als Tool;
   bestätigt, dass die Agenten und Workflows verfügbar sind.
2. Erstellt mit der Analyst-/PM-Persona ein kurzes **Product Brief**.
3. Lasst die **Product-Manager**-Persona das Brief in ein Product Requirements Document überführen.
4. Lasst die **Architekt**-Persona einen Stack wählen und eine Architektur samt zentralen
   Entscheidungen erstellen.
5. Zerlegt die Arbeit in **Stories** und lasst dann den Dev-Loop der **Entwickler**-Persona laufen –
   prüft die Diffs und führt die App während des Baus aus.
6. Führt mit dem Skill `bmad-qa-generate-e2e-tests` einen **QA**-Durchgang aus (eine QA-Persona gibt es nicht) und nutzt den **Party Mode** mindestens
   einmal, um einen übergreifenden Trade-off aufzulösen.
7. Nutzt die **Hilfe** der Methode, wann immer ihr unsicher seid, was als Nächstes kommt.

## Erfolgskriterien

- [ ] BMAD ist installiert und für Claude Code konfiguriert
- [ ] Brief, PRD und Architektur existieren als Artefakte der jeweiligen Personas
- [ ] Stories wurden über den Dev-Loop der Entwickler-Persona implementiert und die App läuft
- [ ] Der Party Mode wurde mindestens einmal für eine übergreifende Entscheidung genutzt

## Referenzen

- BMAD Method – Repository & README: https://github.com/bmad-code-org/BMAD-METHOD
- BMAD Method: Documentation (beschreibt jetzt die V7-Alpha, nicht v6.12): https://docs.bmad-method.org/
- BMAD Method: v6.12-Branch: https://github.com/bmad-code-org/BMAD-METHOD/tree/V6.12
