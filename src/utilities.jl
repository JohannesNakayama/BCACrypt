function animate(automaton::Automaton)
    for (i, frame) in automaton.states
        Base.run(`clear`)
        imshow(Gray{N0f8}.(Int.(frame)))
        sleep(0.1)
    end
end
