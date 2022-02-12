test_string = "halo i bims 1 idiot lol"
char_rep = collect(test_string)
int_rep = Int8.(char_rep)
bit_rep = bitstring.(int_rep)

m = [[parse(Bool, i) for i in row] for row in bit_rep]

if mod(length(m), 2) != 0
    pushfirst!(m, zeros(Bool, length(m[1])))
end

# MARGOLUS NEIGHBORHOOD SCHEME

function start_at(t)
    return mod(t, 2) == 0 ? (1, 1) : (2, 2)
end

t = 1
start = start_at(t)

i = 1

for i in start[1]:2:length(m)
    for j in start[2]:2:length(m[1])
        margolus = [
            [
                m[i][j],
                m[i][j+1 <= length(m[1]) ? j+1 : 1]
            ],
            [
                m[i+1 <= length(m) ? i+1 : 1][j],
                m[i+1 <= length(m) ? i+1 : 1][j+1 <= length(m[1]) ? j+1 : 1]
            ]
        ]
        println(margolus)
    end
end


# for i in start[1]:nrows(mat)
#   for j in start[2]:8  # if 8-bit strings are used
#     # Margolus neighborhood given by:
#     mat[i,   j  ], mat[i  , j+1]
#     mat[i+1, j  ], mat[i+1, j+1]
#       --> broadcast -> mod 8
#     -> apply rule
#     # end of row flips over to beginning if start = [2, 2] (modulo)
#   end
#   # end of mat flips over to beginning if start = [2, 2](modulo)
# end



# BLOCK CELLULAR AUTOMATA COMPONENTS (WIKIPEDIA)
#
# * a regular lattice of cells
# * a finite set of the states that each cell may be in
# * a partition of the cells into a uniform tessellation in which each tile of the partition has the same size an shape (NOTE: for example Margolus neighborhood)
# * a rule for shifting the partition after each time step
# * a transition rule, a function that takes as input an assignment of states for the cells in a single tile and produces as output another assignment of states for the same cells



