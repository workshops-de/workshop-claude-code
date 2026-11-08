## Going further — beyond the contract

- **Protect the tests:** add a `PreToolUse` hook (`Edit|Write`) that blocks edits under
  `contract-tests/` with `exit 2` while the agent implements the backend. Block only files that
  already exist, so new test files can still be written:

  ```bash
  file=$(jq -r '.tool_input.file_path // empty')
  case "$file" in
    */contract-tests/*) [ -e "$file" ] && { echo "Contract tests are the spec: fix the code, not the test." >&2; exit 2; } ;;
  esac
  exit 0
  ```
- **Close the auth gap** — your backend may be stricter than the reference: require a valid Bearer
  token for `POST`, `PUT`, `PATCH`, and `DELETE`. Mark those tests as "own backend only" so the
  suite stays green against the reference API.
- **Contract from the spec** — have the agent compare your backend's generated OpenAPI document
  with `docs/openapi.json` and list the differences.
- **Tests in automation** — see the Headless & Automation task to run the gates non-interactively.
