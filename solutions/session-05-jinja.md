# Session 5 solutions: jinja 3.1.4

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 1986 | `src/jinja2/runtime.py`, `LoopContext.cycle` | Off-by-one (1-based vs 0-based) | `args[self.index % len(args)]` | `self.index0` |
| 1988 | `src/jinja2/filters.py`, `do_batch` | Off-by-one | `(linecount - len(tmp) - 1)` | `(linecount - len(tmp))` |
| 1991 | `src/jinja2/environment.py`, `Environment._load_template` | Wrong boolean operator | `not self.auto_reload and template.is_up_to_date` | `or` |
| 1994 | `src/jinja2/filters.py`, `do_truncate` | Boundary | `if len(s) < length + leeway` | `<=`. **No failing test**; add one to `tests/test_filters.py::TestFilter` |

Failing tests before fixes: 8. `test_regression::test_cached_extends` and `test_loader::test_caching` are #1991. `test_async::test_cycling` and `test_core_tags::test_cycling` are the same bug (#1986), the async loop context inherits from the sync one.
