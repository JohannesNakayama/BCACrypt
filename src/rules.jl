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
