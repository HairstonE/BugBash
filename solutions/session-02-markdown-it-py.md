# Session 2 solutions: markdown-it-py 3.0.0

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 88 | `markdown_it/common/utils.py`, `escapeHtml` | Ordering / shared transform | `&` replacement moved to last, so already-escaped `&lt;` becomes `&amp;lt;` | Replace `&` first |
| 91 | `markdown_it/rules_block/heading.py`, level-count loop | Off-by-one | `level <= 4` in the `while` | `level <= 6` |
| 93 | `markdown_it/rules_block/hr.py` | Wrong comparison / boundary | `if cnt <= 3: return False` | `if cnt < 3` |
| 96 | `markdown_it/common/utils.py`, `normalizeReference` | Missing normalization step | `.strip()` removed before whitespace collapse | `string.strip()` inside the `re.sub` |

Failing tests before fixes: 87. ~80 are from #88 alone. Point of this session: when one bug causes most failures, fix it first and rerun before touching anything else.
