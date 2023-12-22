using HorizonSideRobots
r=Robot("untitled.sit", animate=true)
include("lib.jl")
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

function mark_kross!(r::Robot)
    for side in (Nord,West,Sud,Ost)
        putmarkers!(r,side)
        move_markers(r,inverse(side))
    end
    putmarker!(r)
end


function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false 
        move!(r,side) 
        putmarker!(r)
    end
end


function move_markers(r::Robot,side::HorizonSide) 
    while ismarker(r)==true 
        move!(r,side)  
    end
end





#запуск
mark_kross!(r)