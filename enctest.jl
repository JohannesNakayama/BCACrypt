using Pkg
Pkg.activate(".")

using BCACrypt
using Random

mat = Random.rand(Bool, 50, 50)
automaton = Automaton(mat, 1)
k1 = Random.rand(Bool, 256)
k2 = Random.rand(Bool, 256)
for (i, rule) in enumerate(k1)
    if rule
        run!(automaton, k2[i] + 1, tron)
    else
        run!(automaton, k2[i] + 1, critters)
    end
end
