function animate(automaton::Automaton, width::Int=20, colormap = [(0, 0, 0), (255, 255, 255)])
    for (i, frame) in automaton.states
        Base.run(`clear`)
        print(heatmap(frame, colorbar = false, colormap = colormap, width = width))
        sleep(0.1)
    end
end
