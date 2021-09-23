# special lignt beam


#L_str = split(readline())                   # List in string format
#N_X   = map(n -> parse(Int64,n),L_str)      # List in int format
#N     = N_X[1];
#X     = N_X[2];


function Laser_beam_length(N::Int64,X::Int64)
# Directions :
# Horizontal = _ = H
# South_west = / = SW
# North_west = \ = NW

        Length::Int64 = 0;
        Front_NW = zeros(Int64,2,1);
        Front_NW[1] = X;
        Front_NW[2] = N-X; # PA
        Front_H  = zeros(Int64,2,N-1);
        Front_H[1,:] = transpose(1:N-1);
        Front_SW = zeros(Int64,2,N-1);
        Front_SW[2,:] = transpose(1:N-1);

       Init_point = zeros(Int64,2,1); Init_point[2] = N-X;
       Init_dir = "H";   #  Horizontal

       Coordinates = Init_point;
       Curr_point = Init_point;
       Curr_dir   = Init_dir;
       pursue     = true;

       while pursue
          Length     = Length + 1; #  steps of 1.

          if Curr_dir == "H"
             Temp_vec   = zeros(Int64,2,1); Temp_vec[1] = 1;
             Curr_point = Curr_point + Temp_vec;
             if Curr_point_belongs(Curr_point,Front_NW)
                Curr_dir = "SW"
             elseif Curr_point_belongs(Curr_point,Front_SW)
                Curr_dir = "NW"
             else
                Front_H = Expand_fronts(Front_H,Curr_point);
             end

          elseif  Curr_dir == "NW"
             Temp_vec   = zeros(Int64,2,1); Temp_vec[1] = -1;Temp_vec[2] = 1;
             Curr_point = Curr_point + Temp_vec;

             if Curr_point_belongs(Curr_point,Front_SW)
                Curr_dir = "H"
             elseif Curr_point_belongs(Curr_point,Front_H)
                Curr_dir = "SW"
             else
                Front_NW = Expand_fronts(Front_NW,Curr_point);
             end

          else     #  "SW"
             Temp_vec   = zeros(Int64,2,1); Temp_vec[1] = 0;Temp_vec[2] = -1;
             Curr_point = Curr_point + Temp_vec;

             if Curr_point_belongs(Curr_point,Front_H)
               Curr_dir = "NW"
            elseif Curr_point_belongs(Curr_point,Front_NW)
               Curr_dir = "H"
            else
               Front_SW = Expand_fronts(Front_SW,Curr_point);
            end
          end
          pursue =  Pursue_condition(Curr_point,N,X);
          Coordinates = hcat(Coordinates,Curr_point);
       end
    return Length,Coordinates
end

function Pursue_condition(Curr_point::Array{Int64,2},N::Int64,X::Int64)
   return !((Curr_point[1] == 0)&&(Curr_point[2] == N-X))
end

function Curr_point_belongs(Curr_point::Array{Int64,2},Front::Array{Int64,2})
   Belongs = false;
   for u = 1:size(Front,2)
      Belongs = (Front[1,u]==Curr_point[1])&&(Front[2,u]==Curr_point[2])
      Belongs && break
   end
   return Belongs
end

function Expand_fronts(Front_to_expand::Array{Int64,2},Current_point::Array{Int64,2})
   Expanded_front = copy(Front_to_expand);
   Expanded_front = hcat(Expanded_front,Current_point);
   return Expanded_front
end


N = 5
X = 3

len,Coord = Laser_beam_length(N,X)


# Now plot the coordinates

# plot the triangle
a = [1;0]
b = [1/2;sqrt(3)/2];
Coords_triangle = zeros(Float64,2,3*N+1)
Coords_triangle[1,2:N+1]= 1:N

for n = 1:N
  Coords_triangle[:,N+n+1]   = N*a+ (b-a)*n
  Coords_triangle[:,2*N+n+1] = N*b-n*b
end
#Coords_triangle = hcat(zeros(2,1),Coords_triangle);
#Coords_triangle = hcat([1,0],Coords_triangle);
New_coords = zeros(size(Coord));#[1,:]*a + Coord[2,:]*b
for uu = 1:size(New_coords,2)
   New_coords[:,uu] = Coord[1,uu]*a + Coord[2,uu]*b
end
using Plots

gr()
plot(Coords_triangle[1,:], Coords_triangle[2,:], lw = 3,legend=false, axis=nothing, aspect_ratio = 1.,showaxis = false)
plot!(New_coords[1,:], New_coords[2,:],lw = 1,linecolor = :reds,legend=false, axis=nothing,aspect_ratio = 1.,showaxis = false)
plot!(New_coords[1,:], New_coords[2,:],seriestype = :scatter,legend=false, axis=nothing, aspect_ratio = 1.,showaxis = false )

#plot!(Coords_triangle[1,2+N:2N+1], Coords_triangle[2,2+N:2N+1], lw = 3)
#plot!(Coords_triangle[1,2+2N:3N+1], Coords_triangle[2,2+2N:3N+1], lw = 3)



#@btime len,Coord = Laser_beam_length(N,X)
