using HorizonSideRobots
r=Robot("untitled.sit",animate=true)

function oblique_cross!(r::Robot)
    for vertical_direction in (Nord,Sud)
        for horizontal_direction in (Ost,West)
            putmarkers_diagonal!(r,vertical_direction, horizontal_direction)
            move_diagonal_markers!(r,vertical_direction, horizontal_direction)
        end
    end
    putmarker!(r)
end

function free_diagonal!(r::Robot,vertical_direction::HorizonSide, horizontal_direction:: HorizonSide)
    if !isborder(r,vertical_direction)
        move!(r,vertical_direction)
        if !isborder(r,horizontal_direction)
            move!(r,horizontal_direction)
            return true
        else
            move!(r,inverse(vertical_direction))
        end
    elseif !isborder(r,horizontal_direction)
        move!(r,horizontal_direction)
        if !isborder(r,vertical_direction)
            move!(r,vertical_direction)
            return true
        else
            move!(r,inverse(horizontal_direction))
            return false
        end
    else 
        return false
    end
end
function inverse(side::HorizonSide)
    if side==Nord
        return Sud
    end
    if side==Sud
        return Nord
    end
    if side==West
        return Ost
    end
    if side==Ost
        return West
    end
end 
 


function putmarkers_diagonal!(r::Robot,vertical_direction::HorizonSide, horizontal_direction:: HorizonSide)
    while free_diagonal!(r,vertical_direction, horizontal_direction)==true
        putmarker!(r)
    end
end

function move_diagonal_markers!(r::Robot,vertical_direction::HorizonSide, horizontal_direction:: HorizonSide)
    while ismarker(r)
        move!(r,inverse(vertical_direction))
        move!(r,inverse(horizontal_direction))
    end
end



#запуск
oblique_cross!(r)