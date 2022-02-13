mutable struct Automaton
    states::Array{Any}
    function Automaton(init_state::AbstractMatrix, init_start::Int)
        new([(init_start, init_state)])
    end
end

function run!(automaton::Automaton, steps::Int, rule::Function)
    for step in 1:steps
        curr_state = deepcopy(automaton.states[end][2])
        start = automaton.states[end][1] == 1 ? 2 : 1
        next_state = zeros(Bool, size(curr_state))
        for i in start:2:size(curr_state)[1]
            for j in start:2:size(curr_state)[2]
                pos1 = [i, j]
                pos2 = [i, j+1 <= size(curr_state)[2] ? j+1 : 1]
                pos3 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j]
                pos4 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j+1 <= size(curr_state)[2] ? j+1 : 1]
                block = [
                    curr_state[pos1...] curr_state[pos2...];
                    curr_state[pos3...] curr_state[pos4...]
                ]
                next_state = rule(curr_state, next_state, block, pos1, pos2, pos3, pos4)
            end
        end
        push!(automaton.states, (copy(start), deepcopy(next_state)))
    end
    return automaton
end
