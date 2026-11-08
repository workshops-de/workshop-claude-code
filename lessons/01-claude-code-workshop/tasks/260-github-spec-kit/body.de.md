## Überblick

Erlebt **Spec-Driven Development** mit GitHub Spec Kit, indem ihr ein Briefing über einen
expliziten, mehrstufigen Prozess zu einer funktionierenden Anwendung bringt. Die **Spezifikation
ist die Quelle der Wahrheit**, die Implementierung wird daraus erzeugt – ein scharfer Gegensatz zu
Ad-hoc-Prompting.

## Hintergrund

Spec Kit liefert Slash Commands, die euch durch Leitprinzipien, eine Spezifikation des _Was_ und
_Warum_, einen optionalen Klärungsdurchgang, einen technischen Plan, eine Aufgabenzerlegung, eine
optionale Konsistenzanalyse und schließlich die Implementierung führen. Baut hier eine **neue,
kleine Anwendung** (nicht euren BookMonkey-Build), damit die Methode – nicht die Domäne – die
Lektion ist. Vorgeschlagenes Briefing: ein persönlicher Habit-Tracker (Gewohnheiten definieren,
täglich einchecken, Streaks sehen).

## Schritte

1. Installiert die Spec-Kit-CLI und **initialisiert** ein neues Projekt für Claude Code; bestätigt,
   dass die Spec-Driven-Slash-Commands verfügbar sind.
2. Legt die **Leitprinzipien** des Projekts fest (Qualität, Tests, Barrierefreiheit,
   lokale Datenhaltung).
3. **Spezifiziert**, was gebaut werden soll und warum – mit Fokus auf User Stories und
   Anforderungen, nicht auf Technologie.
4. Führt einen **Klärungsdurchgang** aus und beantwortet die Fragen, die er aufwirft.
5. Erstellt einen **technischen Plan** und dann eine **Aufgabenzerlegung** in kleine, unabhängige
   Einheiten.
6. Optional: Führt eine **Konsistenzanalyse** aus und **implementiert** dann – prüft die Diffs und
   führt die App während des Baus aus.
7. Ändert eine Anforderung und übt, **zuerst die Spec** zu aktualisieren und die Arbeit dann neu
   abzuleiten.

## Erfolgskriterien

- [ ] Spec Kit ist installiert und mit der Claude-Code-Integration initialisiert
- [ ] Constitution, Spezifikation, Plan und Tasks existieren als dauerhafte Artefakte
- [ ] Die App wurde aus den Tasks implementiert und läuft
- [ ] Ihr habt für eine geänderte Anforderung zuerst die Spec aktualisiert und die Arbeit dann neu
      abgeleitet

## Referenzen

- Spec Kit – Repository & README: https://github.com/github/spec-kit
- Spec Kit – Documentation: https://github.github.io/spec-kit/
- Spec Kit – Spec-Driven methodology: https://github.com/github/spec-kit/blob/main/spec-driven.md
- uv (required to install the CLI): https://docs.astral.sh/uv/
