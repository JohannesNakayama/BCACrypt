test_string = "halo i bims 1 idiot lol"
char_rep = collect(test_string)
int_rep = Int8.(char_rep)
bit_rep = bitstring.(int_rep)


# MARGOLUS NEIGHBORHOOD SCHEME
#
# if t mod 2 == 0
#   start = [1, 1]
# else
#   start = [2, 2]
# end
#
# for i in start[1]:nrows(mat)
#   for j in start[2]:8  # if 8-bit strings are used
#     # Margolus neighborhood given by:
#     mat[i,   j  ], mat[i  , j+1]
#     mat[i+1, j  ], mat[i+1, j+1]
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



