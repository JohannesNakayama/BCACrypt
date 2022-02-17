using Pkg
Pkg.activate(".")

using Images
using TestImages
using ImageInTerminal
using Sixel
using BCACrypt
using Random

mat = Random.rand(Bool, 50, 50)
automaton = Automaton(mat, 1)
run!(automaton, 100, critters)

for state in automaton.states
    Base.run(`clear`)
    imshow(Gray{N0f8}.(Int.(state[2])))
    sleep(0.1)
end
