# Tanias counting

function Result_after_k_subtractions(n::UInt32,k::UInt8)

result =  n;

    for u = 1:k
        if mod(result,10) == 0
            result = result/10;
        else
            result = result - 1;
        end
    end
    return result
end


 println(Result_after_k_subtractions(convert(UInt32,1000000000),convert(UInt8,9)))
