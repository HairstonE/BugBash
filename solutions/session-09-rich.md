# Session 9 solutions: rich 13.7.1

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 3312 | `rich/_wrap.py`, `divide_line` | Boundary | `remaining_space > word_length` | `>=` |
| 3315 | `rich/text.py`, `Text.truncate` | Off-by-one | `set_cell_size(self.plain, max_width) + "…"` | `max_width - 1` |
| 3319 | `rich/style.py`, `Style._add` | Swapped operands | `new_style._color = self._color or style._color` | `style._color or self._color` (compare to `_bgcolor` line below). **No direct test**; add to `tests/test_style.py` |
| 3322 | `rich/table.py`, `Table._collapse_widths` | Wrong function (`max` for `min`) | `max_reduce = [max(excess_width, column_difference)]` | `min(...)`. **No direct test**; add to `tests/test_table.py` |

Failing tests before fixes: 56. About 45 are #3312 (anything that renders wrapped text). ~5 `test_truncate_ellipsis*` are #3315. `test_traceback_console_theme_applies` and `test_inline_styles_*` are partly #3319. `test_render_table` is a mix of #3312 and #3322; it will still fail after fixing wrap.
Point of this session: a 56-failure wall. Pick the test closest to a primitive (`test_text.py`) first, not the one at the top of the list.
