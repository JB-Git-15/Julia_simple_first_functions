

# BBQ _easy
N     = parse(Int64,readline())
L_str = split(readline())                  # List in string format
L_Int = map(n -> parse(Int64,n),L_str)  # List in int format
L_sorted = sort(L_Int,rev = true)

println(sum(L_sorted[2:2:2N]))
