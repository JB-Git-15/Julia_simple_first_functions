# Dominos piling
function Num_of_dominos(String_file::String)

    f   = open(String_file);
    Arr = readlines(f);
    close(f)

    P = split(Arr[1],' ')
    m = parse(Int8,P[1][1])
    n = parse(Int8,P[2][1])

    num ::Int8 = 0
    if (mod(m,2) == 0)&&(mod(n,2)!=0)
        num = (m/2)*n;
    elseif (mod(n,2) == 0)&&(mod(m,2)!=0)
        num = (n/2)*m;
    elseif (mod(n,2) == 0)&&(mod(m,2)==0)
        num = (m/2)*n;
    elseif (mod(m,2) != 0)&&(mod(n,2)!=0)
        if max(m,n) == 1
            num = 0
        else
           max_mn = max(m, n)
           min_mn = min(m,n)
           num    = ((max_mn - 1)/2)*min_mn + floor(Int8,min_mn/2)
        end
    end
   return num
end


num  = Num_of_dominos("Input_file5.txt")
