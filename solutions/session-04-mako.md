# Session 4 solutions: mako 1.3.5

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 389 | `mako/lookup.py`, `TemplateLookup.adjust_uri` | Wrong path join | `posixpath.join(relativeto, uri)` | `posixpath.join(posixpath.dirname(relativeto), uri)` |
| 391 | `mako/util.py`, `LRUCache._manage_size` | Inverted sort | `reverse=False` in the `sorted(...)` by timestamp | `reverse=True` (newest first, then slice off the tail) |
| 394 | `mako/runtime.py`, `_kwargs_for_include` | Shared-state overwrite / precedence | Dropped `and arg not in kwargs` from the condition | Restore it (compare with `_kwargs_for_callable` directly above) |
| 397 | `mako/filters.py`, `xml_escape` | Regex missing a character | Character class `[&<">]` lost `\'` | `r'([&<"\'>])'`. **No failing test**; candidate must add one in `test/test_filters.py` |

Failing tests before fixes: 63. Roughly 55 come from #389 (every include/inherit/namespace test). Fix it first.
`test_cache::test_dynamic_key_with_imports` and `test_exceptions::*` are collateral from #389, not their own bugs.
