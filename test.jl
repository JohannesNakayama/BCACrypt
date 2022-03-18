using Pkg
Pkg.activate(".")

using BCACrypt
using Random


# Block cellular automaton
# Base.run(`clear`)
# println("Run automaton on random matrix.")
# sleep(1)
# automaton = Automaton(Random.rand(Bool, 30, 30), 1)
# run!(automaton, 100, critters)
# animate(automaton, 30)


# Nice critters run
# m = zeros(Bool, 50, 50)
# m[23:27, 23:27] = Random.rand(Bool, 5, 5)
# automaton = Automaton(m, 1)
# run!(automaton, 100, critters)
# animate(automaton, 50)


# Encryption / decryption
# secretkey = SecretKey()
# plaintext = open(f -> read(f, String), "example.txt")
# println("Encryption...")
# @time ciphertext = encrypt(plaintext, secretkey)
# println("Decryption...")
# @time deciphered = decrypt(ciphertext, secretkey)


# Fancy run with all rules
mat = zeros(Bool, 50, 50)
mat[36:45, 36:45] = Random.rand(Bool, 10, 10)
automaton = Automaton(mat, 1)
run!(automaton, 200, critters)
run!(automaton, 200, tron)
run!(automaton, 200, reverse_critters)
animate(automaton, 0.08)



