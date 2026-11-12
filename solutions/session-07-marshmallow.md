# Session 7 solutions: marshmallow 3.21.3

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 2262 | `src/marshmallow/validate.py`, `Range.__call__` | Swapped branches of a conditional | `value <= self.min if self.min_inclusive else value < self.min` | `value < self.min if self.min_inclusive else value <= self.min` (compare to the max line) |
| 2265 | `src/marshmallow/validate.py`, `Length.__call__` | Boundary | `length >= self.max` | `>` |
| 2268 | `src/marshmallow/fields.py`, `Field.__init__` | Wrong default | `self.allow_none = False if allow_none is None else allow_none` | `self.allow_none = load_default is None if allow_none is None else allow_none` |
| 2271 | `src/marshmallow/schema.py`, `Schema._deserialize`, the `if raw_value is missing:` block | Wrong variable (attr vs data key) | `field_name in partial` | `attr_name in partial`. **No failing test**; add to `tests/test_schema.py` |

Failing tests before fixes: 7. The two `*_deserialize_multiple_invalid_items` failures are #2265: List/Tuple tests use `Length` validators. Good practice in not fixing List.
