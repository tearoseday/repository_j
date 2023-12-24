function along!(stop_condition::Function, robot, side)
    while stop_condition() == false
        move!(robot, side)  
    end
end
function snake!(stop_condition :: Function, robot, side1::HorizonSide, side2::HorizonSide)
    s = side1
    along!(() -> isborder(robot, s) || stop_condition(), robot, s)
    while !isborder(robot, s2) && !stop_condition()
        move!(robot, s2)
        s = inverse(s)
        along!(() -> isborder(robot, s) || stop_condition(), robot, s)
    end
end
function try_move!(robot, side::HorizonSide)
    if isborder(robot, side)
        return false
    else
        move!(robot, side)
        return true
    end
end
function along!(stop_condition::Fuction, robot, side)   ###другая реализация along!
    while stop_condition() == false && try_move!(robot, side)
    end
end

