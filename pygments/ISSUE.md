# Open issues (session 10)

Run the suite: `pip install -e . wcag-contrast-ratio && python -m pytest tests -q`

(The `tests/examplefiles` golden corpus is removed from this snapshot to keep it small. `tests/snippets` is kept.)

21 tests are red, in five different files including `test_guess.py`, `test_cmdline.py` and `test_words.py`, which are not where any bug lives. Four reports. Two have no failing test. Fix the code; add regression tests for those two.

---

## #2698 Leading indentation of the first line is lost

```python
highlight("    x = 1\n", PythonLexer(), RawTokenFormatter())
```

The first token is `Name 'x'` with no preceding `Whitespace '    '`. Every other line keeps its indentation. Snippet golden files for eight lexers now fail, and `guess_lexer` picks the wrong lexer for several samples whose `analyse_text` keys off leading whitespace. Started after the last change to input preprocessing.

---

## #2701 `linespans` ids are off by one

`HtmlFormatter(linespans="L")` with the default `linenostart=1` emits `<span id="L-2">` for the first line. `lineanchors="L"` correctly emits `L-1` for the same input.

---

## #2704 `hl_lines` highlights the line after the one requested

```python
HtmlFormatter(hl_lines=[2])
```

on a three-line input wraps line 3 in `<span class="hll">`, not line 2. `hl_lines=[1]` highlights line 2. Docs say `hl_lines` is 1-based. No test covers this.

---

## #2707 `get_lexer_by_name` became case-sensitive

`get_lexer_by_name("Python")` → `ClassNotFound`. `"python"` works. The docs say alias lookup is case-insensitive, and plugin lexers (entrypoint path) still are. No test covers mixed-case lookup.
