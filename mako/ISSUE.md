# Open issues (session 4)

Run the suite: `pip install -e . babel && python -m pytest test -q`

63 tests are red. Most share one cause. One report below has no failing test. Fix the code, add a regression test for the uncovered one.

---

## #389 Relative includes resolve to the wrong path

With a lookup rooted at `templates/`:

```
templates/
  index.html        -> <%include file="partials/header.html"/>
  partials/
    header.html     -> <%include file="nav.html"/>
```

Rendering `index.html` fails with `Can't locate template for uri 'partials/header.html/nav.html'`. The include inside `header.html` should resolve relative to the *directory* containing `header.html`, i.e. `partials/nav.html`. Inheritance (`<%inherit file="../base.html"/>`) breaks the same way.

---

## #391 LRU template cache evicts the most recently used entries

`TemplateLookup(collection_size=10)`: after loading 15 templates, the 10 that survive are the oldest, not the most recent. A hot template gets evicted on every prune and re-parsed. Looks like a cache-policy regression.

---

## #394 Include arguments are overwritten by context variables

```mako
## index.html, rendered with render(name="outer")
<%include file="greet.html" args="name='inner'"/>

## greet.html
<%page args="name"/>
Hello ${name}
```

Output is `Hello outer`. The explicit `args` on the include should win over the enclosing context. This worked in 1.2.

---

## #397 `x` (xml) filter no longer escapes apostrophes

```python
Template("${v | x}").render(v="it's <b>")
```

→ `it's &lt;b&gt;`. Should be `it&#39;s &lt;b&gt;`. The `h` filter is fine; only `x` regressed. No test covers this. Please add one.
