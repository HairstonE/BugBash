# Session 10 solutions: pygments 2.18.0

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 2698 | `pygments/lexer.py`, `Lexer._preprocess_lexer_input` | Wrong method argument | `text = text.strip()` in the `elif self.stripnl:` branch | `text.strip('\n')` |
| 2701 | `pygments/formatters/html.py`, `HtmlFormatter._wrap_linespans` | Off-by-one | `i = self.linenostart` | `i = self.linenostart - 1` (compare to `_wrap_lineanchors` right above, which has the comment explaining why) |
| 2704 | `pygments/formatters/html.py`, `HtmlFormatter._highlight_lines` | Off-by-one | `if i in hls:` | `if i + 1 in hls:` (the trailing comment still says `i + 1`; the code was changed without the comment). **No failing test** |
| 2707 | `pygments/lexers/__init__.py`, `get_lexer_by_name`, builtin-lexer loop | Dropped normalization | `if _alias in aliases:` | `if _alias.lower() in aliases:` (the entrypoint loop a few lines down still has `.lower()`). **No failing test** |

Failing tests before fixes: 21. Eight `tests/snippets/*` golden files, nine `test_guess.py`, `test_cmdline::test_stream_opt`, `test_words::test_affixes_regexes` are all #2698. `test_html_formatter::test_linespans` is #2701.
Point of this session: 100k+ line codebase. Don't read it. `rg "stripnl"` and `rg "linespans"` get you to both bugs in under a minute. Tests in `test_guess.py` are the trap: the lexers aren't wrong, their input is.
