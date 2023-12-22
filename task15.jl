using HorizonSideRobots
r=Robot("untitled.sit", animate=true)

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
right(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4))
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

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

function way_to_edge!(r::Robot)
    numsteps_sud1=0
    while !isborder(r, Sud)
        move!(r, Sud)
        numsteps_sud1+=1
    end
    numsteps_west=0
    while !isborder(r, West)
        move!(r, West)
        numsteps_west+=1
    end
    numsteps_sud2=0
    if !isborder(r,Sud)
        while !isborder(r, Sud)
            move!(r, Sud)
            numsteps_sud2+=1
        end
    end
    return (numsteps_sud2,numsteps_west,numsteps_sud1)
end
function go_to_initial_position(r::Robot,initial_position)
    numsteps_sud2=initial_position[1]
    numsteps_west=initial_position[2]
    numsteps_sud1=initial_position[3]
    for i in 1:numsteps_sud2
        move!(r,Nord)
    end
    for n in 1:numsteps_west
        move!(r,Ost)
    end
    for n in 1:numsteps_sud1
        move!(r,Nord)
    end
end


function mark_frame_perimetr!(r::Robot)
    initial_position=way_to_edge!(r)
    for side in (Nord, Ost, Sud, West)
        putmarkers!(r, side)
    end
    way_to_edge!(r)
    go_to_initial_position(r,initial_position)
end

movements!(r::Robot, side::HorizonSide, num_steps::Int) =
for _ in 1:num_steps
    move_if_possible!(r,side)
end

function putmarkers!(r::Robot,side::HorizonSide)
    num_steps=0 
    while move_if_possible!(r, side) == true
        putmarker!(r)
        num_steps += 1
    end 
    return num_steps
end

mark_frame_perimetr!(r)
