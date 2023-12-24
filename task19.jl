using HorizonSideRobots
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))
function numsteps_mark_along!(r, direct)::Int
    num_steps = 0
    while !isborder(r, direct)
        move!(r, direct)
        putmarker!(r)
        num_steps += 1
    end
    return num_steps
end
function along!(r, direct, num_steps)::Nothing
    for _ in 1:num_steps
        move!(r, direct)
    end
end
function mark_star!(r, directs)
    for side in directs
        num_steps = numsteps_mark_along!(r, side)
        along!(r, inverse(side), num_steps)
    end
    putmarker!(r)
end
mark_kross!(r) = mark_star!(r, (Nord, West, Sud, Ost))
mark_kross_x!(r) = mark_star!(r, ((Nord, West), (Sud, West), (Sud, Ost), (Nord, Ost)))