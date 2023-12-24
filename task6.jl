using HorizonSideRobots
function task6!(r::Robot)
    initial_position=way_to_edge!(r)
    frame!(r)
    way_to_edge!(r)
    go_to_initial_position(r,initial_position)
end

function frame!(r::Robot)
    while !isborder(r,Nord)
        while !isborder(r,Ost)
            move!(r,Ost)
            if isborder(r,Nord)
                mark_perimetr!(r,Ost)
                return
            end
        end
        move!(r,Nord)
        while !isborder(r,West)
            move!(r,West)
            if isborder(r,Nord)
                mark_perimetr!(r,West)
                return
            end
        end
        move!(r,Nord)
    end
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

function putmarkers!(r::Robot, direction_of_movement::HorizonSide, direction_to_border::HorizonSide)
    while isborder(r,direction_to_border)
        putmarker!(r)
        move!(r,direction_of_movement)
    end
    move!(r,direction_to_border)
end

function mark_perimetr!(r::Robot,Side::HorizonSide)
    if Side == Ost
        direction_of_move=(Ost,Nord,West,Sud)
        border=(Nord,West,Sud,Ost)
    else
        direction_of_move=(West,Nord,Ost,Sud)
        border=(Nord,Ost,Sud,West)
    end
    for i in (1,2,3,4)  
        putmarkers!(r, direction_of_move[i], border[i])
    end
end
