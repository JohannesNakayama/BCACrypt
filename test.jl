using UnicodePlots, ColorSchemes, Random

# Create initial state (later: clear text)
ct = "halo i bims 1 idiot lol"
ct_char = collect(ct)
ct_int = Int8.(ct_char)
ct_bitstr = bitstring.(ct_int)
ct_m = [[parse(Bool, i) for i in row] for row in ct_bitstr]
if mod(length(ct_m), 2) != 0
    pushfirst!(ct_m, zeros(Bool, length(ct_m[1])))
end
mat = hcat(ct_m...)'


# Create cellular automaton
mutable struct Automaton
    states::Array{Any}
end

function run!(automaton::Automaton, steps::Int)
    for step in 0:steps
        curr_state = deepcopy(automaton.states[end])
        start = mod(step, 2) == 0 ? 1 : 2
        next_state = zeros(Bool, size(curr_state))
        for i in start:2:size(curr_state)[1]
            for j in start:2:size(curr_state)[2]
                pos1 = [i, j]
                pos2 = [i, j+1 <= size(curr_state)[2] ? j+1 : 1]
                pos3 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j]
                pos4 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j+1 <= size(curr_state)[2] ? j+1 : 1]
                margolus = [
                    curr_state[pos1...] curr_state[pos2...];
                    curr_state[pos3...] curr_state[pos4...]
                ]
                block_sum = sum(margolus)
                if block_sum == 2
                    next_state[pos1...] = curr_state[pos1...]
                    next_state[pos2...] = curr_state[pos2...]
                    next_state[pos3...] = curr_state[pos3...]
                    next_state[pos4...] = curr_state[pos4...]
                elseif block_sum in [0, 1, 4]
                    next_state[pos1...] = !curr_state[pos1...]
                    next_state[pos2...] = !curr_state[pos2...]
                    next_state[pos3...] = !curr_state[pos3...]
                    next_state[pos4...] = !curr_state[pos4...]
                else
                    next_state[pos1...] = !curr_state[pos4...]
                    next_state[pos2...] = !curr_state[pos3...]
                    next_state[pos3...] = !curr_state[pos2...]
                    next_state[pos4...] = !curr_state[pos1...]
                end
            end
        end
        push!(automaton.states, deepcopy(next_state))
    end
    return automaton
end

function animate(automaton::Automaton, width::Int=20)
    for frame in automaton.states
        Base.run(`clear`)
        print(heatmap(frame, colorbar = false, colormap = [(0, 0, 0), (255, 255, 255)], width = width))
        sleep(0.2)
    end
end

# Example 1: clear text
Base.run(`clear`)
println("Run automaton on \"clear text\" from above.")
sleep(1)
automaton = Automaton([mat])
run!(automaton, 100)
animate(automaton, 8)

# Example 2: random
Base.run(`clear`)
println("Run automaton on random matrix.")
sleep(1)
automaton = Automaton([Random.rand(Bool, 50, 50)])
run!(automaton, 100)
animate(automaton, 50)
