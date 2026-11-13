## Lernziele

- **Feature:** alle Bausteine der Woche zusammen: CLAUDE.md, Kontext, Rules, Skills, Hooks, Deny-Regeln, Tests.
- **Konzepte:** Was gehört wohin? Beraten (CLAUDE.md, Rules) gegen Durchsetzen (Hook, Deny-Regel). Weniger ist mehr im Kontext.
- **Übungsfeld:** ein frischer Klon von `bookmonkey-legacy`, ohne die Dateien aus den früheren Aufgaben.
- **Takeaways:** Ein gutes Setup ist klein, geprüft und begründet. Jede Gruppe kann sagen, was sie bewusst weggelassen hat.

## Ablauf (75 min)

| Zeit | Was |
| --- | --- |
| 5 min | Gruppen bilden (3 bis 4 Personen), frisch klonen |
| 10 min | Erkunden im Plan Mode |
| 5 min | Tabelle „Was gehört wohin?“ |
| 25 min | Bauen, Rollen nach jedem Baustein wechseln |
| 5 min | Probe in einer neuen Session |
| 25 min | Red-Team-Prompt und Vorstellen, je Gruppe 4 min, danach kurze Runde |

## Hinweise zur Durchführung

- Geht von Gruppe zu Gruppe und stellt je eine Frage aus „Habt ihr an alles gedacht?“. Gebt keine Antworten, fragt nach dem Beweis: „Zeigt mir, dass das wirkt.“
- Häufig wird die `CLAUDE.md` zu lang oder wiederholt nur die README. Fragt dann: „Was davon würde Claude ohne die Datei falsch machen?“
- Hooks werden gern gebaut, aber nicht getestet. Fragt, wie sie zeigen, dass der Hook blockiert.
- Beim Vorstellen auf Punkt 2 achten (bewusst weggelassen). Das ist die eigentliche Entscheidungskompetenz.
- Leitet danach zu Block 502 über: Andrés Setup und das Starter-Plugin als Vergleich mit den Gruppen.
- Keine Lösungen oder Fundstellen aus `bookmonkey-legacy-trainer` in die Runde geben, die Gruppen sollen selbst erkunden.
- Pflicht sind nur `CLAUDE.md` und ein durchsetzender Baustein (Hook oder Deny-Regel). Rule und Skill sind Kür, wenn Zeit bleibt.
- Die Red-Team-Runde vor dem Vorstellen beantwortet live die Frage „Was ist, wenn Claude dasselbe mit einem anderen Befehl erreicht?“. Ein Angriffs-Prompt pro Gruppe, nicht mehr.
- Fragt jemand, wer bei einem Widerspruch zwischen Rule und `CLAUDE.md` gewinnt: Es ist keine feste Rangfolge dokumentiert, beides landet im Kontext. Den Widerspruch auflösen.
- Bei mehr als 5 Gruppen: 3 min je Gruppe oder nur Punkt 1 und 2.

## Worauf ihr beim Rundgang achten könnt

- Laufen Start- und Testbefehl aus der `CLAUDE.md` wirklich? Steht die Node-Version drin?
- Ist ein Skript, das Daten löscht, abgesichert oder mindestens mit Rückfrage?
- Wurde die README ungeprüft geglaubt?
- Wurde der Hook mit einem echten Block getestet?
- Ist klar, was in `settings.json` und was in `settings.local.json` gehört?
- Gibt es einen Review-Schritt mit frischem Blick (Subagent oder zweite Session)?
- Ist die `CLAUDE.md` unter etwa 30 Zeilen?

**Hinweis:** Die Aufgabe wurde noch nicht als Ganzes mit einer Gruppe durchgespielt. Die Zeiten sind eine erste Schätzung.
