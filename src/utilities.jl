function animate(automaton::Automaton, speed::AbstractFloat)
    println("This function plays a terminal animation of the automaton you provided.")
    println("The implementation is sloppy and ad-hoc, I just wanted something flashy to show in the terminal...")
    println("As the print function is slow, this animation might flicker quite a lot, especially for automata of large size (e.g. (100, 100)).")
    println("If you suffer from epilepsy or are in any way sensitive to such flickering, I'd be careful running this function.")
    println("Do you still wish to proceed? [Please type 'Yes']")
    yes = readline()
    if yes == "Yes"
        for (i, frame) in enumerate(automaton.states)
            if mod(i, 2) == 1
                continue
            end
            Base.run(`clear`)
            imshow(Gray{N0f8}.(Int.(frame[2])))
            sleep(speed)
        end
    else
        println("Aborted animation.")
    end
end
