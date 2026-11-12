# Open issues (session 7)

Run the suite: `pip install -e ".[tests]" && python -m pytest tests -q`

7 tests are red. Four reports. One has no failing test. Two of the failing tests (`*_deserialize_multiple_invalid_items`) are about List and Tuple fields, which is not where their bug lives.

---

## #2262 `Range` validator inverts the inclusive flag on the lower bound

`validate.Range(min=1, max=10)` rejects `1` ("Must be greater than or equal to 1"). `validate.Range(min=1, min_inclusive=False)` accepts `1`. Upper bound behaves correctly.

---

## #2265 `Length(max=N)` rejects strings of exactly N characters

`validate.Length(max=3)("abc")` raises. `Length(min=3)("abc")` passes. Docs: "succeeds if the value's length is between min and max, inclusive".

---

## #2268 Field with `load_default=None` no longer accepts `None`

```python
class S(Schema):
    nickname = fields.Str(load_default=None)

S().load({"nickname": None})   # {'nickname': ['Field may not be null.']}
```

The docs say: if `load_default=None` and `allow_none` is unset, `allow_none` is implicitly `True`. Explicit `allow_none=True` still works.

---

## #2271 `partial=(...)` ignores fields that use `data_key`

```python
class S(Schema):
    name = fields.Str(data_key="Name", required=True)
    age = fields.Int(required=True)

S().load({"age": 3}, partial=("name",))
# ValidationError: {'Name': ['Missing data for required field.']}
```

`partial` is documented as a list of *attribute* names, so `("name",)` should work. Passing `("Name",)` works, which is backwards. No test covers partial + data_key; please add one.
