<details>
<summary>💡 Tipp 1: Hooks schnell halten</summary>

Sie laufen bei jeder Änderung. Formatiert eine Datei und führt einen Typecheck aus – lasst nicht
bei jedem Handgriff des Agenten die komplette Test-Suite laufen.

</details>

<details>
<summary>💡 Tipp 2: Euer Guard blockiert nicht?</summary>

Prüft den Exit-Code. Nur `exit 2` blockiert einen `PreToolUse`-Aufruf; `exit 1` loggt nur einen
Fehler und lässt die Aktion durch.

Dasselbe gilt für den Typecheck-Hook: Reagiert Claude nie auf Typfehler, beendet sich euer
`PostToolUse`-Skript wahrscheinlich mit `0` oder `1`. Nur `exit 2` legt Claude den stderr vor.

</details>

<details>
<summary>💡 Tipp 3: Hooks von Hand debuggbar machen</summary>

Schickt ein Beispiel-JSON per Pipe in euer Skript
(`echo '{"tool_input":{"file_path":".env"}}' | ./guard.sh`) und prüft den Exit-Code mit `echo $?`.

</details>

<details>
<summary>💡 Tipp 4: Zulässige Übergänge vor dem Coden festlegen</summary>

Schreibt zuerst das Zustandsdiagramm auf und lehnt alles andere in der Domain-Funktion ab. Einen
Button zu verstecken ist keine Regel – ruft die Funktion mit einem unzulässigen Übergang auf und
prüft, dass sie ihn verweigert.

</details>
