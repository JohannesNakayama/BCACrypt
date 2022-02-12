module BCACrypt

using UnicodePlots
using ColorSchemes
using Random
using Chain

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

# The automaton
mutable struct Automaton
    states::Array{Any}
    function Automaton(init_state::AbstractMatrix, init_start::Int)
        new([(init_start, init_state)])
    end
end


# Run the automaton `steps` times with `rule`
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

function critters(
    curr_state, next_state, block,
    pos1, pos2, pos3, pos4
)
    block_sum = sum(block)
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
    return next_state
end

function reverse_critters(
    curr_state, next_state, block,
    pos1, pos2, pos3, pos4
)
    block_sum = sum(block)
    if block_sum == 2
        next_state[pos1...] = curr_state[pos1...]
        next_state[pos2...] = curr_state[pos2...]
        next_state[pos3...] = curr_state[pos3...]
        next_state[pos4...] = curr_state[pos4...]
    elseif block_sum in [0, 3, 4]
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
    return next_state
end

function tron(
    curr_state, next_state, block,
    pos1, pos2, pos3, pos4
)
    block_sum = sum(block)
    if block_sum in [0, 4]
        next_state[pos1...] = !curr_state[pos1...]
        next_state[pos2...] = !curr_state[pos2...]
        next_state[pos3...] = !curr_state[pos3...]
        next_state[pos4...] = !curr_state[pos4...]
    else
        next_state[pos1...] = curr_state[pos1...]
        next_state[pos2...] = curr_state[pos2...]
        next_state[pos3...] = curr_state[pos3...]
        next_state[pos4...] = curr_state[pos4...]
    end
    return next_state
end

function animate(automaton::Automaton, width::Int=20)
    for (i, frame) in automaton.states
        Base.run(`clear`)
        print(heatmap(frame, colorbar = false, colormap = [(0, 0, 0), (255, 255, 255)], width = width))
        sleep(0.1)
    end
end

# Encryption module

mutable struct SecretKey
    rule_seq
    step_seq
end

function encode(text::String)
    mat = @chain begin
        collect(text)
        Int8.(_)
        bitstring.(_)
        [[parse(Bool, i) for i in row] for row in _]
        if mod(length(_), 2) != 0
            pushfirst!(_, zeros(Bool, length(_[1])))
        end
        Matrix(hcat(_...)')
    end
    return mat
end

function decode(encoded_text::Matrix)
    chars = []
    for i in 1:size(encoded_text)[1]
        decoded_char = @chain begin
            encoded_text[i, 1:end]
            Int8.(_)
            string.(_)
            reduce(*, _)
            parse(Int16, _, base = 2)
            Char(_)
        end
        push!(chars, decoded_char)
    end
    decoded_text = reduce(*, [string(c) for c in chars])
    return decoded_text
end

function encrypt(cleartext::String, secretkey::SecretKey)
    mat = encode(cleartext)
    automaton = Automaton(mat, 1)
    for (rule, n_steps) in zip(secretkey.rule_seq, secretkey.step_seq)
        if rule
            run!(automaton, n_steps, critters)
        else
            run!(automaton, n_steps, tron)
        end
    end
    return automaton.states[end]
end

function decrypt(ciphertext::Any, secretkey::SecretKey)
    mat = ciphertext
    automaton = Automaton(ciphertext[2], ciphertext[1] == 1 ? 2 : 1)
    for (rule, n_steps) in zip(reverse(secretkey.rule_seq), reverse(secretkey.step_seq))
        if rule
            run!(automaton, n_steps, reverse_critters)
        else
            run!(automaton, n_steps, tron)
        end
    end
    return automaton.states[end]
end

end  # end module
