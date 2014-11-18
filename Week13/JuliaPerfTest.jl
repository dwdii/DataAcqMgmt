function mean(a)
    sum = 0
    count = length(a)
    for x in a
        sum = sum + x
    end

    m = sum / count
    #println(sum)
    println()

    m
end


b = Array(Int32, 100000000)
rand!(1:20, b)

@time mean(b)

