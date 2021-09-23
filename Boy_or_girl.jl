# boy or girl


function boy_or_girl(s::String)

    if mod(length(unique(s)),2)== 0
        println("CHAT WITH HER!")
    else
        println("IGNORE HIM!")

    end


end

s = "wjmzbmrmx"
boy_or_girl(s)
