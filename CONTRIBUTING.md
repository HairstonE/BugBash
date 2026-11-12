# Add bugs and projects

## Add a bug to an existing project

1. Make sure the project's tests pass before your change. Run `uv run pytest`
   from the project folder.
2. Plant one small, realistic bug in the source. Good bugs look like mistakes
   a tired programmer makes: an off-by-one, a swapped argument, a wrong
   comparison, a missing condition.
3. Make sure at least one existing test fails because of the bug. If no test
   fails, the bug is not findable. Pick a different bug or a different spot.
4. Describe the symptom in the project's `ISSUE.md`, in the voice of a user
   bug report. Give the behavior, not the location.
5. Add the location, the change, and the fix to the matching file in
   `solutions/`. Follow the format of the existing files there.

## Add a new project

1. Copy a release of an upstream open-source Python project into a new top
   folder. Keep its `LICENSE` file.
2. Delete folders that are not needed for the exercise (docs, CI
   configuration).
3. Set up the project and make sure the full test suite passes clean:

   ```
   uv venv --python 3.12
   uv pip install -e . pytest
   uv run pytest
   ```

4. Plant the bugs (see the section above).
5. Write the project's `ISSUE.md` and a `solutions/session-NN-<project>.md`.
6. Add the project to the order list in `README.md`.

## Rules for good planted bugs

- The bug must cause a test failure or a clearly wrong behavior that
  `ISSUE.md` describes.
- The bug must be findable from the symptom. Do not plant bugs in dead code.
- Plant bugs in source code, not in tests. Tests are the ground truth.
- Keep `ISSUE.md` free of locations. It describes what a user sees, not where
  the code is wrong.
