# helpful maths

function main2(s::String)

    splited = split(s,"+")
    Splitted_sort = string.(sort([parse(Int8,splited[i]) for i=1:length(splited)],rev = false))
    Fin_str   =  Splitted_sort[1];

    if length(Splitted_sort)>1
        for u = 2:length(Splitted_sort)
            Fin_str = Fin_str*"+"
            Fin_str = Fin_str*Splitted_sort[u]
        end
    end
    return Fin_str
end

s = "1+4+3+2+1"
println(main2(s))
