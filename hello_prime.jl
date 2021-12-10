function prime_factors(num)
    factors = []
    global i = 2
    global limit = num
    while i <= limit
        if limit % i == 0
            push!(factors, i)
            limit /= i
        else
            i += 1
        end
    end
    factors
end

function get_input(s)
    try
        parse(Int64, s)
    catch
        println("Please enter a valid integer")
        Nothing
    end
end

println("Enter an integer to see its prime factors (enter q to quit)")
s = get_input(readline())
while s != Nothing
    println(prime_factors(s))
    global s = get_input(readline())
end