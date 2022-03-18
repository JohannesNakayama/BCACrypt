# BCACrypt

*A symmetric encryption scheme using reversible cellular automata.*



## How to run

*Block cellular automata with animations*:

```julia
using BCACrypt
using Random

mat = zeros(Bool, 50, 50)
mat[21:25, 21:25] = Random.rand(Bool, 5, 5)

automaton = Automaton(mat, 1)
run!(automaton, 200, tron)
animate(automaton)
```

## Status

* [x] Encryption / decryption works
* [x] Quick'n'dirty animations for the terminal
* [x] Encoding works (decoding is wonky)
* [x] Fix decoding
* [ ] Refactor automaton (should be possible to make more performant)
* [ ] Look into other reversible rules
* [ ] Is there something like Wolfram codes for BCAs?

