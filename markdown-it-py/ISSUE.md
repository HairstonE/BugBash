# Open issues (session 2)

Run the suite: `pip install -e ".[testing]" && python -m pytest tests -q`

87 tests are red. Most of them have one cause. Find it first, then the rest. Fix the code so all tests pass and the reports below are resolved. Add a regression test where none exists.

---

## #88 Entities are double-escaped in output

```python
MarkdownIt().render('a < b & "c"')
```

gives `<p>a &amp;lt; b &amp; &amp;quot;c&amp;quot;</p>`. Expected `<p>a &lt; b &amp; &quot;c&quot;</p>`.

---

## #91 Level 6 headings render as paragraphs

`###### six` → `<p>###### six</p>`. Levels 1 through 5 are fine.

---

## #93 Three-character thematic break not recognized

`---` on its own line renders as `<p>---</p>`. `----` works. CommonMark requires only three.

---

## #96 Reference links with padded labels don't resolve

```markdown
[foo]

[ foo ]: /url
```

Renders `<p>[foo]</p>`. Spec says label matching strips leading/trailing whitespace, so this should be a link. Was working in 2.x.
