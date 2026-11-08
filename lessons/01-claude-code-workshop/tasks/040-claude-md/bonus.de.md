## Weiterführend: Memory im großen Maßstab und im Wandel

- **`CLAUDE.md` pro Verzeichnis** hält Anweisungen lokal bei dem Code, den sie regeln
  (Regeldateien und pfadbezogene Regeln folgen in der Memory-Rules-Aufgabe).
- **`claudeMdExcludes`** überspringt Memory für Pakete, die ihr nie anfasst.
- **Auto Memory** lässt Claude während einer Session von selbst dauerhafte Erkenntnisse sammeln.
- **Lasst das Memory sich entwickeln**: Ein `Stop`-Hook kann eine Session auswerten und
  `CLAUDE.md`-Updates vorschlagen, solange die aufgedeckte Lücke frisch ist.

Versucht, einen einfachen `Stop`-Hook einzurichten, der euch nach einer langen Session daran
erinnert, die `CLAUDE.md` zu überprüfen.
