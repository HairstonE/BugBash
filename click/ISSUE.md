# Open issues (session 3)

Run the suite: `pip install -e . && python -m pytest tests -q`

9 tests are red. One of the reports below has no failing test yet. Fix the code so everything passes, and write a regression test for the report that lacks one.

---

## #2617 Case-insensitive Choice rejects valid input

```python
@click.option("--env", type=click.Choice(["Dev", "Prod"], case_sensitive=False))
```

`--env dev` → `Error: Invalid value for '--env': 'dev' is not one of 'Dev', 'Prod'.`

Also seeing the reverse: with the default `case_sensitive=True`, `--env DEV` is accepted. Looks like the flag is doing the opposite of what it says.

---

## #2619 IntRange rejects a value equal to the lower bound

`click.IntRange(0, 3)` with `-vvv` on a counted option fails. Digging in, `IntRange(5, 10).convert("5", ...)` raises "5 is not in the range 5<=x<=10". Upper bound is fine. Open ranges (`min_open=True`) accept the bound, which is backwards.

---

## #2621 Environment variable ignored when a default_map is set

```python
@click.command(context_settings={"default_map": {"port": 8000}})
@click.option("--port", type=int, envvar="APP_PORT")
def cli(port):
    click.echo(port)
```

`APP_PORT=9000 python app.py` prints `8000`. The documented precedence is command line → environment → default_map → default. Env should win here. No test covers this; please add one.

---

## #2624 Required `multiple=True` option no longer errors when omitted

```python
@click.option("--tag", multiple=True, required=True)
```

Invoking with no `--tag` now runs the command with `tag=()` instead of `Error: Missing option '--tag'`. Same for `nargs=-1` arguments.
