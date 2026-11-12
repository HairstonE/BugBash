# Open issues (session 1)

Run the suite: `pip install -e . && python -m pytest tests -q`

CI went red after the last refactor of `_parser.py` / `_re.py`. Four user reports came in the same week. Fix the code so all tests pass and the reports below are resolved. Add a regression test for anything that doesn't already have one.

---

## #412 Trailing comma in array raises "Unclosed array"

```toml
ports = [8000, 8001, 8002,]
```

```
tomli.TOMLDecodeError: Unclosed array (at line 1, column 27)
```

The TOML spec allows a trailing comma. This worked in the previous release.

---

## #415 Timezone offsets come back inverted

```toml
ts = 1979-05-27T00:32:00-07:00
```

`tomli.loads(...)["ts"].utcoffset()` returns `datetime.timedelta(seconds=25200)` (+7h). Should be -7h.

---

## #418 Duplicate keys in inline tables are silently accepted

```toml
point = { x = 1, x = 2 }
```

No error, `point == {"x": 2}`. Duplicate keys are invalid TOML and the top-level parser rejects them. Inline tables should too.

---

## #421 Error column is off on the first line

```python
tomli.loads("a = ")
```

Reports `column 4`. Previous release said `column 5` (1-based, pointing at the position after the `=` and space). Only wrong on line 1; later lines are fine.
