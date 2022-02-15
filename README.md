# BCACrypt

*A symmetric encryption scheme using reversible cellular automata.*

## Status

* [x] Encryption / decryption works
* [x] Quick'n'dirty animations for the terminal
* [x] Encoding works (decoding is wonky)
* [x] Fix decoding
* [ ] Refactor automaton (should be possible to make more performant)
* [ ] Look into other reversible rules
* [ ] Is there something like Wolfram codes for BCAs?

## How to run

* see `test.jl`
* `julia test.jl` -> runs the `critters` BCA on a random `(30, 30)` matrix (with animation) and demonstrates encryption/decryption
* decoding doesn't work properly yet, so demo is not yet ideal

