using HorizonSideRobots
function move!(robot, side, num_steps)
    for _ in 1:num_steps
        HorizonSideRobots.move!(robot, side)
    end
end

