mutable struct SecretKey
    rule_seq
    step_seq
end

SecretKey() = SecretKey(Random.rand(Bool, 32), Random.rand(0:127, 32))

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

