# Open issues (session 6)

Run the suite: `pip install -e . pytest-timeout watchdog cryptography && python -m pytest tests -q`

12 tests are red across four files, including `middleware/test_proxy_fix.py` which is not where any bug lives. Four reports. One has no failing test. Fix the code, add the missing regression test.

---

## #2904 `request.host` mangles custom ports on http

Behind nginx on `http://spam:8080`, `request.host` is `spam:8`. `https://spam:8443` is fine. Looks like the standard-port stripping is too greedy. `ProxyFix` tests fail for the same reason.

---

## #2907 `If-Modified-Since` equal to `Last-Modified` returns 200 instead of 304

```python
is_resource_modified(environ, last_modified=dt)
```

with `If-Modified-Since` set to exactly `dt` returns `True` (modified). RFC 7232: the resource is unmodified if `Last-Modified` is *not later than* the header. Equal should be 304. One second earlier works, so this is a boundary on the comparison.

---

## #2911 `MultiDict.setlist` aliases the caller's list

```python
values = ["a", "b"]
d = MultiDict()
d.setlist("k", values)
values.append("c")
d.getlist("k")   # ['a', 'b', 'c']
```

Docstring says the list is shallow-copied before insertion. It isn't.

---

## #2913 Empty quoted header parameter comes back with its quotes

```python
parse_options_header('form-data; name=""')
```

→ `('form-data', {'name': '""'})`. Expected `{'name': ''}`. A one-character quoted value like `"a"` unquotes fine. No test covers the empty quoted case; please add one.
