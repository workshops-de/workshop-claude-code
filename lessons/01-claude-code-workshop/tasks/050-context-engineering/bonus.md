## Going further: checkpointing, goals and caching

- **Checkpointing**: rewind Claude's file edits and conversation to an earlier state when a long
  session goes wrong. Files changed only through Bash (`echo`, `mv`) stay as they are.
- **`/goal`**: set a completion condition so Claude keeps working across turns instead of
  stopping after one.
- **Context-window simulation**: see exactly what loads and what each read costs.
- **Prompt caching**: understand why a model switch or `/compact` triggers a slow uncached turn.

Try deliberately triggering a checkpoint rewind after a session goes in the wrong direction.
