# Agent Efficiency Rules

> Referenced from `CLAUDE.md` Section 10. Applies to all work in this repo.

- **No unnecessary Bash commands.** Don't run `flutter analyze`, `flutter test`,
  `flutter pub get`, `dart format`, or similar verification commands after every
  small edit. Batch changes and verify once, not per-file.
- **Skip `flutter analyze` / `flutter test` for now.** These are deferred until
  the end of the current build phase, then run once as a final check — not
  after each feature or file.
- **No exploratory `find`/`grep`/`ls` sweeps** when the file location is already
  known from the folder structure in `CLAUDE.md` Section 4.
- **No re-reading files just edited.** The Edit/Write tools already confirm
  success; re-reading to "double check" wastes tokens.
- Prefer fixing multiple related files in one pass over one-file-at-a-time
  verification loops.
