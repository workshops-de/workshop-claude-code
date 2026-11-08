## Weiterführend – über den Contract hinaus

- **Tests schützen:** Fügt einen `PreToolUse`-Hook (`Edit|Write`) hinzu, der Änderungen unter
  `contract-tests/` mit `exit 2` blockiert, solange der Agent das Backend implementiert. Blockiert
  nur Dateien, die schon existieren, damit neue Testdateien weiter geschrieben werden können:

  ```bash
  file=$(jq -r '.tool_input.file_path // empty')
  case "$file" in
    */contract-tests/*) [ -e "$file" ] && { echo "Contract tests are the spec: fix the code, not the test." >&2; exit 2; } ;;
  esac
  exit 0
  ```
- **Die Auth-Lücke schließen** – euer Backend darf strenger sein als die Referenz: Verlangt für
  `POST`, `PUT`, `PATCH` und `DELETE` ein gültiges Bearer-Token. Markiert diese Tests als „nur
  eigenes Backend“, damit die Suite gegen die Referenz-API grün bleibt.
- **Contract aus der Spec** – lasst den Agenten das generierte OpenAPI-Dokument eures Backends mit
  `docs/openapi.json` vergleichen und die Unterschiede auflisten.
- **Tests in der Automatisierung** – in der Aufgabe Headless & Automation führt ihr die Gates
  nicht-interaktiv aus.
