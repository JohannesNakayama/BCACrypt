module BCACrypt

# using UnicodePlots
using ColorSchemes
using Random
using Chain
using Images
using Sixel
using ImageInTerminal

export Automaton
export SecretKey
export run!
export critters
export reverse_critters
export tron
export encrypt
export decrypt
export encode
export decode
export animate

include("automaton.jl")
include("rules.jl")
include("utilities.jl")
include("encryption.jl")

end  # end module
