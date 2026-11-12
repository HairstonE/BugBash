# BugBash

Practice for debugging interviews. This repository holds ten real open-source
Python projects. Each project contains planted bugs. You find the bugs and fix
them.

**CAUTION: Do not open `solutions/` before you finish a project. The files in
it name each bug and give the fix.**

## How a session works

1. Pick a project from the order below.
2. Read the `ISSUE.md` in that project. It is the bug report.
3. Set up the project and run its tests (see Setup).
4. Find the cause and fix it, as you would in an interview. Read the failing
   tests. Find a working neighbor. Bisect. Print values.
5. When your fix is done, compare it with the matching file in `solutions/`.

## Suggested order

1. tomli
2. markdown-it-py
3. click
4. mako
5. jinja
6. werkzeug
7. marshmallow
8. itsdangerous
9. rich
10. pygments

## Setup

Each project is independent and gets its own virtual environment. You need
[uv](https://docs.astral.sh/uv/) and Python 3.12.

The fast way:

```
./setup.sh tomli        # one project
./setup.sh all          # all ten projects
```

The manual way, from inside a project folder:

```
uv venv --python 3.12
uv pip install -e . pytest
```

Two projects need test extras instead of a plain install:

- markdown-it-py: `uv pip install -e ".[testing]" pytest`
- marshmallow: `uv pip install -e ".[tests]" pytest`

Run the tests from inside the project folder:

```
uv run pytest
```

## Editor setup

Open each project folder as its own editor workspace, for example
`code BugBash/tomli` or `zed BugBash/tomli`. If you open the repository root,
the editor may not find the project's `.venv`.

**VS Code.** Each project ships a `.vscode/settings.json` that points at the
project's `.venv` and enables pytest discovery. Install the Microsoft Python
extension. Run `./setup.sh <project>` first so the `.venv` exists. Then the
Testing panel lists the tests, and you can debug one test from its gutter
button.

**Zed.** Zed finds the `.venv` on its own. If the status bar shows another
Python, run `toolchain: select` and pick the project's `.venv`. Press `F4` to
start the debugger and pick the detected pytest entry, or click the gutter
button next to a test.

**Any other environment.** Nothing depends on an editor. Each project is a
normal editable install, so `uv run pytest` and `pdb` work from the terminal.

## Use with Claude Code

The `CLAUDE.md` file configures Claude Code as a coach that does not give
spoilers. It fixes environment problems, runs tests on request, and explains
debugging method. It does not name bug locations, diagnose test failures, or
write fixes. After you say a project is done, it compares your diff with the
solution.

## Add more bugs or projects

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Licenses and attribution

Each project is a modified copy of an upstream open-source project and keeps
its original `LICENSE` file. The copies are for practice only. The bugs are
planted. Do not report them to the upstream maintainers. This repository is
not affiliated with the upstream projects.
