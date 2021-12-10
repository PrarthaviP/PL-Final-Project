using Statistics
using LinearAlgebra

# # matrices
# A = [1 2 3; 4 5 6; 7 8 9]
# transpose = A'
# rvrs = reverse(A, dims=1)
# println(transpose) # matrix transpose
# println(rvrs) # matrix flipped vertically
# println(A*A)

# # lexical scoping
# square = 0
# i = 0
# while i < 100
#     global square = i^2
#     print("$square, ")
#     global i += 1
# end

# # overloading
# function powers(base::Float64, power::Float64)
#     println("Two floats")
#     base^power
# end

# function powers(base::Float64, power::Int64)
#     println("Integer exponent")
#     base^power
# end

# println(powers(4.56, 2.5))
# println(powers(4.2, 2))