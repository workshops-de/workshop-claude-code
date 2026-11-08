<details>
<summary>💡 Tipp 1: Den Agenten auf Definitionen festnageln</summary>

„Kommt darauf an“ ist ein Zeichen, eine schärfere Frage zu stellen. Nicht jedes Buch gehört zu einer
Reihe und nicht jedes Feld ist Pflicht – schaut in den Vertrag und sagt es ausdrücklich, statt
etwas anzunehmen.

</details>

<details>
<summary>💡 Tipp 2: Die rohe OpenAPI-Datei importieren?</summary>

Führt `/context` davor und danach aus. Jeder Import wird beim Start geladen, bei jedem Prompt. Eine
Zusammenfassung auf einem Bildschirm plus ein Verweis auf die vollständige Datei ist meist besser
als die ganze Datei.

</details>

<details>
<summary>💡 Tipp 3: Pfadbezogene Regeln laden beim Lesen, nicht bei jedem Prompt</summary>

Eine pfadbezogene Regel taucht erst auf, nachdem Claude eine passende Datei gelesen hat. Wenn
`/context` sie noch nicht anzeigt, bittet den Agenten, eine Datei unter diesem Pfad zu öffnen, und
prüft erneut.

</details>
