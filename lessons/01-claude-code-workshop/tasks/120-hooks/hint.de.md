<details>
<summary>💡 Tipp 1: Der Hook blockiert nicht?</summary>

Startet eine neue Session, denn neue Hook-Einstellungen werden dort geladen. Hilft das nicht, sagt Claude, was ihr beobachtet, und bittet es, den Hook mit einem Beispielaufruf zu testen.

</details>

<details>
<summary>💡 Tipp 2: Der Typecheck-Hook meldet nichts?</summary>

Der Hook muss die Fehler an Claude zurückgeben. Sagt Claude, dass es die Typfehler nach jedem Edit oder Write sehen soll. Danach hilft eine neue Session.

</details>

<details>
<summary>💡 Tipp 3: Hooks schnell halten</summary>

Sie laufen bei jeder Änderung. Ein Typecheck genügt, die komplette Test-Suite gehört nicht dazu.

</details>

<details>
<summary>💡 Tipp 4: Nach dem Umbau blockiert der Hook alles?</summary>

Dann hat das Hook-Skript selbst einen Fehler. Sagt Claude, was ihr seht, zum Beispiel: „Dein Hook blockiert jeden Befehl, repariere ihn.“ Claude kann das Skript weiter mit seinen Datei-Werkzeugen ändern.

</details>

<details>
<summary>💡 Tipp 5: Fachbegriffe für die Leseliste</summary>

Zum Nachsteuern, wenn Claude etwas anderes baut:

- `localStorage`, Schlüssel mit User-ID
- State Machine als reine Funktion, eigene Datei ohne Speicher und React
- Proxy-Matcher in `proxy.ts` um `/reading-list` ergänzen
- Header-Zähler erst nach dem Laden lesen (sonst Hydration-Mismatch)

</details>
