using HorizonSideRobots
function mark_kross!(robot)
    for side in (Nord, West, Sud, Ost)
        num_steps = numsteps_mark_along!(robot, side)
        along!(robot, inverse(side), num_steps)
    end
    putmarker!(robot)
end
function numsteps_mark_along!(robot, direct)::Int
    num_steps = 0
    while !isborder(robot, direct)
        move!(robot, direct)
        putmarker!(robot)
        num_steps += 1
    end
    return num_steps
end
function along!(robot, direct, num_steps):: Nothing
    for _ in 1:num_steps
        move!(robot, direct)
    end
end
inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+2, 4))