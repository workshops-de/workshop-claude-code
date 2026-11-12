> **⚠️ Vorher starten:** jeweils in einem eigenen Terminal, während der ganzen Aufgabe offen lassen.
> - API: `npx bookmonkey-api` (http://localhost:4730)

In dieser Aufgabe geht es um **Test-Driven Development (TDD) mit einem Agenten**: Erst kommen die Tests, dann der Code, und die Tests sagen Claude, wann es fertig ist. Ihr schreibt Tests für das Verhalten der fertigen API und baut damit ein eigenes NestJS-Backend.

Ihr arbeitet in eurem `bookmonkey`-Repository mit Node.js 26.

### 1. Lasst Claude die Tests schreiben

```text
Nutze TDD. Richte ein Package contract-tests/ ein (Vitest, fetch), das die Basis-URL aus der Umgebungsvariable API_URL liest. Schreibe Tests für GET /books/:isbn (200 mit Buchstruktur, 404 bei unbekannter ISBN) und POST /books (201 mit vom Server gesetzten id, createdAt und updatedAt, 409 bei doppelter ISBN, 400 bei fehlendem Titel). Jeder Test nutzt eine eigene ISBN und löscht sein Buch danach wieder mit DELETE. Schließe contract-tests/ in der Root-tsconfig.json aus. Lege in der Root-package.json das Skript "contract" an: cd contract-tests && npx vitest run. Schreibe noch keine Implementierung und führe die Tests noch nicht aus.
```

Es entstehen nur Tests. Sie heißen **Contract-Tests**, weil sie festhalten, wie die API sich verhält.

### 2. Prüft die Tests gegen die echte API

```text
Installiere, was für contract-tests/ fehlt, und führe die Tests mit API_URL=http://localhost:4730 npm run contract gegen die laufende bookmonkey-api aus. Wenn ein Test fehlschlägt, ist der Test falsch und nicht die API: Prüfe mit curl, was die API wirklich antwortet, und korrigiere den Test.
```

Ein Test, der schon gegen die echte API rot ist, beschreibt einen Wunsch und keinen Vertrag. In unserem Lauf war einer rot, weil Claude etwas über die Antwort angenommen hatte, das die API so nicht liefert. Am Ende sind alle grün.

### 3. Ergänzt Randfälle

Randfälle sind ungewöhnliche Eingaben, an die man nicht sofort denkt. Ihr schreibt den Prompt selbst: Claude soll aufzählen, was in den Tests fehlt, die wichtigsten Fälle ergänzen und sie gegen die API auf Port 4730 prüfen.

Zum Beispiel:

```text
Welche Randfälle fehlen in den Contract-Tests für GET /books/:isbn und POST /books? Zähle sie kurz auf, ergänze die wichtigsten als Tests und führe die Suite gegen http://localhost:4730 aus. Schlägt ein neuer Test fehl, korrigiere den Test, nicht die API.
```

### 4. Legt das Backend an

Startet eine neue Session und schickt:

```text
Lege mit npx @nestjs/cli new backend --package-manager npm --skip-git ein NestJS-Backend in backend/ an. Es soll auf Port 3001 laufen, wenn die Umgebungsvariable PORT nicht gesetzt ist. Entferne die Beispielroute samt ihrem Test, es gibt noch keine Books-Endpunkte. Schließe backend/ und contract-tests/ in der Root-tsconfig.json und in der Root-eslint.config.mjs vom Frontend-Tooling aus. Starte das Backend noch nicht.
```

Der Type-Check-Hook aus der Hooks-Aufgabe läuft im Hauptprojekt bei jeder Änderung. `backend/` und `contract-tests/` haben ihre eigene Einstellung, deshalb schließt ihr sie dort aus. Startet das Backend danach in einem zweiten Terminal mit `cd backend && npm run start:dev`.

### 5. Seht die Tests rot

Führt im Root-Ordner `API_URL=http://localhost:3001 npm run contract` aus (PowerShell: `$env:API_URL="http://localhost:3001"; npm run contract`). In unserem Lauf schlugen 14 von 17 Tests fehl, denn das Backend kennt noch keine Books.

### 6. Lasst Claude gerade genug implementieren

Startet eine neue Session und schickt:

```text
Das Backend in backend/ läuft im Watch-Modus unter http://localhost:3001. Implementiere ein Books-Modul gerade so weit, dass die Contract-Tests in contract-tests/ grün werden, die Daten liegen im Speicher. Die Tests brauchen auch DELETE /books/:isbn zum Aufräumen. Ändere nichts in contract-tests/, wenn ein Test rot bleibt, sag mir warum. Prüfe mit API_URL=http://localhost:3001 npm run contract.
```

Claude implementiert und führt die Suite selbst aus, bis sie grün ist.

### 7. Baut einen Gate-Befehl

Ein **Gate** ist ein einzelner Befehl, der alle Prüfungen ausführt. Claude kann ihn selbst starten und weiß so, was „fertig“ heißt.

```text
Lege in der Root-package.json ein Skript "gate" an, das nacheinander Type-Check, Lint, Build, die vorhandenen Tests und die Contract-Tests gegen das Backend ausführt (API_URL standardmäßig http://localhost:3001) und beim ersten Fehler abbricht. Trage in die CLAUDE.md ein, dass vor jedem "fertig" npm run gate grün sein muss und dass dafür die bookmonkey-api (Port 4730) und das Backend laufen müssen. Führe das Gate einmal aus.
```

### 8. Committet euren Stand

```text
Committe alle Änderungen aus dieser Aufgabe. Lies vorher den Diff.
```

### Was gerade passiert ist

Eine laufende, fehlschlagende Test-Suite zeigt Claude genauer als ein Text, was fehlt, und wann es fertig ist. Dafür wurden die Tests **zuerst gegen die Realität** geprüft, und Claude durfte sie nicht ändern. Das Gate braucht die laufende API und das laufende Backend.

**Fertig, wenn** `npm run contract` gegen Port 4730 und gegen euer Backend auf Port 3001 grün ist, `npm run gate` in der `CLAUDE.md` steht und alles committet ist.

<details>
<summary>Mehr dazu</summary>

Mit `curl -X POST http://localhost:4730/dev/reset` stellt ihr die Daten der API wieder her. Einen Hook, der bestehende Testdateien schützt, zeigt der Bonus.

- Common workflows: https://code.claude.com/docs/en/common-workflows
- NestJS: https://docs.nestjs.com/first-steps
- Vitest: https://vitest.dev/guide/

</details>
