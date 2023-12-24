using HorizonSideRobots
function find_hole!(robot)
    side = Ost; n = 0
    while isborder(robot, Nord)
        n += 1
        side = inverse(side)
        move!(robot, side, n)
    end
end
move!(robot, Nord)
side = inverse(side)
move!(robot, side, n)
function move!(robot, side, num_steps)
    for _ in 1:num_steps
        HorizonSideRobots.move!(robot, side)
    end
end
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))