using Plots
using Base

#=
Introductory problems to learn Julia
=#



N = 5;
A = zeros(N,N)

for u = 1:N
    for j = 1:N
        if u == j
            A[u,j]  = -1.0
        elseif abs(u-j) == 1
            A[u,j] = 2.0
        end
    end
end



function my_factorial(n::Int64)
    s::Int64 = 1
    for u in n:-1:1
        s = s*u
    end
    return s
end;


function my_factorial(n::BigInt)
    s::BigInt = 1
    for u in n:-1:1
        s = s*u
    end
    println("with big inputs")
    return s
end


function binomial_rv(n,p)
    num::Int64 = 0
    for u = 1:n
        num = (rand() < p)*1 + num
    end
    return num
end

function estimate_pi(n)
    x = rand(n)
    y = rand(n)
    is_in = zeros(n)
    for u = 1:n
        is_in[u] = (y[u] <= sqrt(1-x[u]*x[u])*1)
    end
    approx_pi = 4*sum(is_in)/n

return approx_pi
end


function AR_1(alphas,T::Int)
    P = zeros(T,length(alphas))
    for n_alp = 1:length(alphas)
        alph_temp = alphas[n_alp]
        for n_t = 2:T
            P[n_t,n_alp] = alph_temp*P[n_t-1,n_alp] + randn()
        end
    end
 return P

end

T = 200
plot(1:T,AR_1([0 0.5 0.99],T), label = ["α = 0" "α = 0.5" "α = 0.99"])
xlabel!("Time steps")




function Logistic_Map(r,T::Int)
     B = zeros(T,length(r))
     B[1,:] .=  0.25
     for n_r = 1:length(r)
        r_temp = r[n_r]
        for n_t = 2:T
            B[n_t,n_r] = r_temp*B[n_t-1,n_r]*(1 - B[n_t-1,n_r])
        end
     end
    return B;
end

T = 400
plot(1:T,Logistic_Map([0 0.5 0.99 1 1.5  2  2.5 ],T), label = ["r = 0" "r = 0.5" "r = 0.99" "r = 1"  "r = 1.5" "r = 2" "r = 2.5"    ])
xlabel!("Time steps")


r = collect(2.9:.0001:4)
B = Logistic_Map(r,T)

plot(r,B[end,:],seriestype = :scatter)
xlabel!("r")
ylabel!("final point")

#=
struct MyType
    data::Array{Float64,2}
    function MyType(data)
        new(data)
    end
end

#Base.getindex(a::MyType, i::Int) = a.data[i]

=#










struct MyRange
    start ::Float16
    step  ::Float16
    stop  ::Float16
end

struct MyArr
    arr::Array{Float64,1}
    function  MyArr(Arr::Array{Float64,1})
        new(Arr)
    end
    function MyArr()
        #temp ::Array{Float64,1}
        temp = Float64[]
        new(temp)
    end
end


struct MyRange3
    start::Int64
    step::Int64
    stop::Int64

    function MyRange3(start::Int64,step::Int64,stop::Int64)
      if (start < stop)&&(step >0)
          new(start,step,stop)
      else
          error("check the boundaries")
      end
    end
    function MyRange3()
        error("there are no start, step and stop")
    end
end

function  _MyRange(a::MyRange3,i::Int64)
    temp = a.start + (i-1)*a.step
    if temp <= a.stop
        return temp
    else
        error("index above highest boundary")
    end
end

function Base.getindex(a::MyRange3, i::Int64)
          return _MyRange(a::MyRange3,i::Int64)
end



 #### Part 2 : range mathod
 struct Arr_linspace
     start::Float64
     stop::Float64
     N::Int64
     arr::Array{Float64,1}
     function Arr_linspace(start::Float64,stop::Float64,N::Int64)
         if (start < stop)&&(N >0)
             arr = zeros(N)
             for u = 1:N
                 arr[u] = start + (u-1)*(stop-start)/(N-1)
             end
             new(start,stop,N,arr)
        else
            error("do it again")
         end
    end
end
    # end
 ############ Part 3 :

# Overload the call on the UnitStepRange to give an interpolated value at intermediate points, i.e. if a=1:2:10, then a(1.5)=2.

#example :: (c::CallTest)(b::Float64) = c.a*b
(LS::Arr_linspace)(b::Float64) = LS.start + ((LS.stop -LS.start)/(LS.N-1))*(b-1)

############ Part 4:
#using Unitful
#module MyUnitsPackage
# unit(Second(15)) == u"s"
