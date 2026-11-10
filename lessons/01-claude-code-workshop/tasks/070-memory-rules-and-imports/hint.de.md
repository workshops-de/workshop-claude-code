<details>
<summary>💡 Tipp 1: Den Agenten auf Definitionen festnageln</summary>

„Kommt darauf an“ ist ein Zeichen, eine schärfere Frage zu stellen. Nicht jedes Buch gehört zu einer
Reihe und nicht jedes Feld ist Pflicht. Sagt Claude, es soll das ausdrücklich festhalten, statt
etwas anzunehmen.

</details>

<details>
<summary>💡 Tipp 2: Die rohe OpenAPI-Datei importieren?</summary>

Jeder Import wird beim Start geladen, bei jedem Prompt. Eine Zusammenfassung auf einem Bildschirm
plus ein Verweis auf die vollständige Datei ist meist besser als die ganze Datei.

</details>

<details>
<summary>💡 Tipp 3: Pfadbezogene Regeln laden beim Lesen, nicht bei jedem Prompt</summary>

Eine pfadbezogene Regel lädt erst, nachdem Claude eine passende Datei geöffnet hat. Fragt Claude vorher,
ob es die Regel kennt, und lasst es danach etwas in `lib/api.ts` ändern. Der Unterschied zeigt sich
in der Antwort.

</details>
