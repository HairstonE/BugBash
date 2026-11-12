# Open issues (session 5)

Run the suite: `pip install -e . && python -m pytest tests -q`

8 tests are red. One report below has no failing test; add one. Note that two of the failing tests are in `test_regression.py` and `test_async.py`, which are not where the bugs live.

---

## #1986 `loop.cycle` starts on the second value

```jinja
{% for row in rows %}{{ loop.cycle('odd', 'even') }}{% endfor %}
```

First row gets `even`. Worked in 3.1.3.

---

## #1988 `batch` filter with `fill_with` leaves the last row one short

```jinja
{% for row in [1,2,3,4,5]|batch(3, 0) %}{{ row }}{% endfor %}
```

Last row is `[4, 5]`. Expected `[4, 5, 0]`. Without `fill_with` it's fine.

---

## #1991 Templates are recompiled on every `get_template` call

Profiling a Flask app shows `FileSystemLoader.get_source` called on every request even though nothing changed on disk and `auto_reload` is the default. Setting `auto_reload=False` makes it worse, not better: now it *does* re-read when the file changes. The two settings seem to be behaving backwards.

---

## #1994 `truncate` cuts strings that fit exactly

```jinja
{{ "hello world"|truncate(11, leeway=0) }}
```

Returns `hello...`. The string is 11 characters and the limit is 11, so it should come back untouched. Docs say strings are truncated only when they *exceed* length plus leeway. No test covers the exact-fit case; please add one.
