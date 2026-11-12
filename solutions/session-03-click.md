# Session 3 solutions: click 8.1.7

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 2617 | `src/click/types.py`, `Choice.convert` | Inverted boolean | `if self.case_sensitive:` guards the casefold block | `if not self.case_sensitive:` |
| 2619 | `src/click/types.py`, `_NumberRangeBase.convert` | Wrong comparison | `operator.lt if self.min_open else operator.le` for `lt_min` | `operator.le if self.min_open else operator.lt` (compare to the `gt_max` line right below it) |
| 2621 | `src/click/core.py`, `Parameter.consume_value` | Wrong precedence / ordering | The `lookup_default` (default_map) block was moved above the `value_from_envvar` block | Env block first, then default_map. **No failing test.** Candidate must write one (CliRunner with `env=` and `default_map` in `context_settings`). |
| 2624 | `src/click/core.py`, `Parameter.value_is_missing` | Wrong boolean operator | `(self.nargs != 1 and self.multiple)` | `or` |

Failing tests before fixes: 9. `test_counting` is a good red herring: it looks like a counting bug but is #2619.
