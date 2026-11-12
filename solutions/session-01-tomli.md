# Session 1 solutions: tomli 2.0.1

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 412 | `src/tomli/_parser.py`, `parse_array`, after `pos += 1` following the comma | Boundary | Removed the `if src.startswith("]", pos): return pos + 1, array` check after skipping whitespace post-comma | Restore the check |
| 415 | `src/tomli/_re.py`, `cached_tz` | Wrong comparison | `sign = 1 if sign_str == "-" else -1` | `== "+"` |
| 418 | `src/tomli/_parser.py`, `parse_inline_table` | Missing validation | Removed `if key_stem in nest: raise suffixed_err(... "Duplicate inline table key ...")` | Restore the check before `nest[key_stem] = value` |
| 421 | `src/tomli/_parser.py`, `suffixed_err.coord_repr` | Off-by-one | `column = pos` on line 1 | `column = pos + 1` |

Failing tests before fixes: 17 (test_data subtests for trailing-comma, array, timezone, milliseconds, duplicate-key etc., `test_error::test_line_and_col`, `test_misc::test_deepcopy`).
Note: `test_deepcopy` fails as a side effect of another bug, not its own. Good moment to practice "the failing test shows where it was noticed, not where it lives."
