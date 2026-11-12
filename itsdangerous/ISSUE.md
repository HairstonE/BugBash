# Open issues (session 8)

Run the suite: `pip install -e . freezegun && python -m pytest tests -q`

3 tests are red. Three reports. Two have no failing test, and one of those is intermittent. Fix the code and add regression tests for both uncovered reports. For the intermittent one, your test must fail deterministically.

---

## #371 Key rotation broken: tokens signed with the previous key are rejected

```python
s = Signer(["old", "new"])
Signer("old").unsign(Signer("old").sign("x"))      # fine
s.unsign(Signer("old").sign("x"))                   # BadSignature
```

Docs: `secret_key` may be a list, newest last, and signatures from any key in the list verify. Only the newest key works now. This breaks every rolling-key deployment.

---

## #374 Token expires one second early

```python
s = TimestampSigner("k")
v = s.sign("x")
# exactly 60 seconds later
s.unsign(v, max_age=60)    # SignatureExpired: Signature age 60 > 60 seconds
```

The message even says `60 > 60`. Age equal to `max_age` should still be valid. No test covers the exact boundary.

---

## #378 Roughly 1 in 256 timestamped tokens are rejected as expired with an enormous age

Production logs show `SignatureExpired: Signature age 1693359385 > 3600 seconds` on freshly minted tokens. It happens in bursts of about a minute every few hours, then stops. Reproduced locally by freezing the clock at `1700000000`: every token signed at that instant fails to unsign ten seconds later. `1700000001` is fine.

No test covers this. Please add one that fails on the current code without relying on the real clock.
