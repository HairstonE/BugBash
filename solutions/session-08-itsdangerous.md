# Session 8 solutions: itsdangerous 2.2.0

| # | File | Bug shape | Planted change | Fix |
|---|---|---|---|---|
| 371 | `src/itsdangerous/signer.py`, `Signer.verify_signature` | Wrong iteration / dropped loop | `for secret_key in self.secret_keys[-1:]:` | `for secret_key in reversed(self.secret_keys):` |
| 374 | `src/itsdangerous/timed.py`, `TimestampSigner.unsign` | Boundary | `if age >= max_age:` | `>`. **No failing test** |
| 378 | `src/itsdangerous/encoding.py`, `int_to_bytes` | Wrong method (strips both ends) | `.strip(b"\x00")` | `.lstrip(b"\x00")`. **No failing test; intermittent** |

Why #378 is 1-in-256: the timestamp is packed big-endian and leading zero bytes are stripped to save space. `strip` also removes *trailing* zero bytes, so any timestamp whose low byte is `0x00` (every 256 seconds, for 1 second) loses its last byte, and `bytes_to_int` right-pads it back as a value 256x smaller. `1700000000 = 0x6553F100`. A good regression test calls `int_to_bytes(1700000000)` and `bytes_to_int` roundtrip, or freezes `time.time` with `mock.patch`/freezegun at that value.

Failing tests before fixes: 3 (all `test_secret_keys`, all #371).
Narration target for this session: #378 is the kind of bug where the stack trace points at `timed.py` but the cause is in `encoding.py`. Say out loud why "age 1693359385" means the timestamp was parsed wrong, not that the clock is wrong.
