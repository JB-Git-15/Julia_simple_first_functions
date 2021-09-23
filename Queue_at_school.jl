# Queue at school (Code Forces)
function Position_after_t_iterations(String_file::String)#n,t,s::String)

    f   = open(String_file);
    Arr = readlines(f);
    P   = split(Arr[1]," ");

    n   = parse(Int8,P[1][1]);
    t   = parse(Int64,P[2][1]);
    S   = Arr[2];
    close(f)

    Old_str   = collect(S);
    New_str = copy(Old_str);

    for u = 1:t
      for num_str = 1:(length(S)-1)
          Letter   = Old_str[num_str];
          Letter_n = Old_str[num_str+1];
              if (Letter =='B')&&(Letter_n == 'G')
                  New_str[num_str] = 'G';
                  New_str[num_str+1] = 'B';
              end
      end
              if (join(Old_str) == join(New_str)) # stopping condition
                  break
              end
                Old_str = copy(New_str);
    end


#5 1
#BGGBG
return join(Old_str)
end

oustr = Position_after_t_iterations("Input_file3.txt")
