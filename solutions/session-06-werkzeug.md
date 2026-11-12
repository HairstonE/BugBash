# Session 6 solutions: werkzeug 3.0.3

(Shipped repo has `tests/test_serving.py`, `tests/live_apps/`, `tests/middleware/test_http_proxy.py` and `test_debug.py::test_basic` removed because they need a live dev server. Not bugs.)

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 2904 | `src/werkzeug/sansio/utils.py`, `get_host` | Wrong string match | `host.endswith("80")` | `host.endswith(":80")` (compare to the `:443` line below it) |
| 2907 | `src/werkzeug/sansio/http.py`, `is_resource_modified` | Boundary | `last_modified < modified_since` | `<=` |
| 2911 | `src/werkzeug/datastructures/structures.py`, `MultiDict.setlist` | Shared-state aliasing | `dict.__setitem__(self, key, new_list)` | `list(new_list)` |
| 2913 | `src/werkzeug/http.py`, `unquote_header_value` | Boundary / off-by-one | `len(value) > 2` | `>= 2`. **No failing test**; add to `tests/test_http.py` |

Failing tests before fixes: 12. All 5 `test_proxy_fix` failures plus 5 `test_get_host` failures are #2904. `test_is_resource_modified_for_range_requests` is #2907 (the test name says "range requests", the bug is in date comparison). `test_basic_interface` is #2911.
Indirection: `werkzeug.http.is_resource_modified` is a thin wrapper; the logic is in `sansio/http.py`. Same for `get_host` (`wsgi.py` → `sansio/utils.py`). Trace through, don't stop at the wrapper.
