using HorizonSideRobots
r=Robot("untitled.sit", animate=true)

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))
left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
right(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4))

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = left(direct_side)
    reverse_side = inverse(orthogonal_side)
    num_steps=0
    while isborder(r,direct_side) == true
        if isborder(r, orthogonal_side) == false
            move!(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end
    #УТВ: Робот или уперся в угол внешней рамки поля, или готов сделать шаг (или несколько) в направлении 
    # side

    if isborder(r,direct_side) == false
        move!(r,direct_side)
        while isborder(r,reverse_side) == true
            move!(r,direct_side)
        end
        result = true
    else
        result = false
    end
    for _ in 1:num_steps
        move!(r,reverse_side)
    end
    return result
end


function mark_kross(r::Robot)
    for side in (Nord, West, Sud, Ost)
        num_steps = putmarkers!(r,side)
        movements!(r,inverse(side), num_steps) # тут шибочно было: move!(...)
    end
end

function putmarkers!(r::Robot,side::HorizonSide)
    num_steps=0 
    while move_if_possible!(r, side) == true
        putmarker!(r)
        num_steps += 1
    end 
    return num_steps
end


movements!(r::Robot, side::HorizonSide, num_steps::Int) =
for _ in 1:num_steps
    move_if_possible!(r,side)
end

mark_kross(r)