using HorizonSideRobots
function move_to_angle!(robot, sides::NTuple{HorizonSide, 2})
    @assert sides in ((Nord, Ost), (Nord, West), (Sud, Ost), (Sud, West))
    sn = Tuple{HorizonSide, Int}[]
    while !isborder(robot, sides[1]) || !isborder(robot, sides[2]) 
        for s in sides                       ##пока не в углу
            n = numsteps_along!(robot, sides[1])
            push!(sn, (s, n))
        end
    end
    return sn
end
function HorizonSideRobots.move!(robot, path::AbstractVector{Tuple{HorizonSide, Int}})
    for sn in path
        move!(robot, sn[1], sn[2])
    end
end