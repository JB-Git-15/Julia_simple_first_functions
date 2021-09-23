# A. New Year and Hurry (Code Forces)
function How_many_problems(String_file::String)

    f   = open(String_file);
    Arr = readlines(f);
    close(f)

    P = split(Arr[1],' ')
    n = parse(Int64,P[1][1])
    k = parse(Int64,P[2][1])

    Vec_t = cumsum(collect(1:n)*5) .+k .-60*4

    return sum((Vec_t.<0)*1)
end


num_prob = How_many_problems("Input_file6.txt")
