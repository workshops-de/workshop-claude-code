## Weiterführend: Checkpointing, Goals und Caching

- **Checkpointing**: Claudes Dateiänderungen und das Gespräch auf einen früheren Stand
  zurücksetzen, wenn eine lange Session schiefläuft. Dateien, die nur über Bash geändert wurden
  (`echo`, `mv`), bleiben, wie sie sind.
- **`/goal`**: eine Abbruchbedingung setzen, damit Claude über mehrere Turns weiterarbeitet, statt
  nach einem anzuhalten.
- **Kontextfenster-Simulation**: genau sehen, was geladen wird und was jedes Lesen kostet.
- **Prompt Caching**: verstehen, warum ein Modellwechsel oder `/compact` einen langsamen Turn ohne
  Cache auslöst.

Versucht, gezielt einen Checkpoint-Rewind auszulösen, nachdem eine Session in die falsche
Richtung gelaufen ist.
