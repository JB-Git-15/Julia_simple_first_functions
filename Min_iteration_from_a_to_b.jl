# minimum iteration numbers
# Yet Another Two Integers Problem


using DelimitedFiles


function main()
    # read text file (for test)

    f = open("Input_file.txt");
    Arr = readlines(f)

    t::Int32  = convert(Int32,size(Arr)[1]-1)  # number of tests

    Tab_a = zeros(Int32,t)
    Tab_b = zeros(Int32,t)
    Num_it= zeros(Int32,t)

    for u = 1:t
        temp     = split(Arr[u+1]," ")
        Tab_a[u] = parse(Int32, temp[1])
        Tab_b[u] = parse(Int32, temp[2])
    end

    close(f)


    for u = 1:t
        abs_diff       = abs(Tab_a[u]-Tab_b[u]);
        Div_ent        = floor(abs_diff/10);
        Rem_eq_to_zer  = convert(Int32,(abs_diff - Div_ent*10 !=0)*1);#convert(Int32, Div_ent)             ;# 0
        Num_it[u]      = Div_ent + Rem_eq_to_zer;
    end

     println(Num_it)

    return Num_it
end

main()
