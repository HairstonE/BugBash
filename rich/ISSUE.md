# Open issues (session 9)

Run the suite: `pip install -e . attrs "markdown-it-py==3.0.0" "pygments==2.18.0" && python -m pytest tests -q`

56 tests are red across 17 files. Four reports. Two of them have no failing test of their own and are only hinted at by failures elsewhere. Fix the code; add regression tests for the two.

---

## #3312 Text wraps one cell early

`Text("Hello World").wrap(console, 5)` gives `["Hell", "o", "Worl", "d"]` instead of `["Hello", "World"]`. A word that exactly fills the remaining width gets pushed to the next line. Panels, tables, rules, syntax, markdown all look wrong as a result.

---

## #3315 Ellipsis truncation is one cell too wide

`Text("Hello").truncate(4, overflow="ellipsis")` → `Hell…` (5 cells). Expected `Hel…`.

---

## #3319 Combining styles keeps the left-hand colour instead of the right

```python
Style(color="red") + Style(color="blue")   # red
```

Docs and every prior release: the right-hand style overrides. Background colour still overrides correctly. Tracebacks and markdown inline styles render with the wrong foreground because of this. No direct unit test.

---

## #3322 Table columns collapse unevenly when the table is too wide

Three columns measuring 10, 40 and 25 squeezed into 50 cells come out `[10, 15, 25]`. The widest column got crushed below the second-widest. Expected `[10, 20, 20]`: shrink the widest down to the next one, then shrink both together. The reduction step is over-shooting. No direct unit test for `_collapse_widths`.
