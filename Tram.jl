#tram

function Tram_capacity(String_file::String)

        f   = open(String_file);
        Arr = readlines(f);
        close(f)

        n   = parse(Int64,Arr[1]);
        Arr_temp = zeros(Int64,n,4);  # 3rd col : Delta:, -1 col + 2nd col, 4rth cum sum

        for u = 1:n
            P = split(Arr[1+u]," ");
            Arr_temp[u,1] = parse(Int64,P[1][1]);
            Arr_temp[u,2] = parse(Int64,P[2][1]);
        end
            Arr_temp[:,3] .= -Arr_temp[:,1] + Arr_temp[:,2]
            Arr_temp[1,4] = Arr_temp[1,3]
        for u = 2:n
            Arr_temp[u,4] = Arr_temp[u-1,4]+Arr_temp[u,3]
        end

   return maximum(Arr_temp[:,4])
end



capacity = Tram_capacity("Input_file4.txt")
