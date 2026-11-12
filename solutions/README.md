# Solutions. Open a session's file only after its timer ends.

Score each session 1 to 3 on each of: orientation, reasoning, tool use, fix quality, validation, narration. Out of 18.

Per-bug log line:
date | session | bug # | min to repro | min to first hypothesis | min to fix | should have checked first | tool fumble

Order of play and what each one is training:

1. tomli: protocol end to end, collateral failure
2. markdown-it-py: one bug causes 80 failures, fix it first
3. click: a bug with no failing test, red-herring test name
4. mako: 63 failures, two bugs with no test, wrapper vs implementation
5. jinja: async and sync tests share one cause
6. werkzeug: sansio wrappers, aliasing, middleware tests failing for a core bug
7. marshmallow: List/Tuple tests failing for a validator bug
8. itsdangerous: intermittent 1-in-256 bug, write a deterministic test
9. rich: 56-failure wall, start from the primitive
10. pygments: 100k lines, grep don't read, guess_lexer trap
