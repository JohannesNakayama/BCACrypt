using Pkg
Pkg.activate(".")
using BCACrypt
using Random


# Block cellular automaton
Base.run(`clear`)
println("Run automaton on random matrix.")
sleep(1)
automaton = Automaton(Random.rand(Bool, 30, 30), 1)
run!(automaton, 100, critters)
animate(automaton, 30)



# Encryption / decryption
rule_seq = [parse(Bool, i) for i in bitstring(Random.rand(UInt32))]
step_seq = Random.rand(0:127, 32)
secretkey = SecretKey(rule_seq, step_seq)
plaintext = "halo i bims 1 idiot lol"
Base.run(`clear`)
sleep(1)
ciphertext = encrypt(plaintext, secretkey)
println(decode(ciphertext[2]))
deciphered = decrypt(ciphertext, secretkey)
println(decode(deciphered[2]))


