using HorizonSideRobots
r=Robot("untitled.sit", animate=true)
include("lib.jl")

function mark_all(r::Robot)
    num_vert = moves!(r,Sud)
    num_hor = moves!(r,West)
    side = Ost
    putmarkers!(r,side)
    while isborder(r,Nord)==false
        move!(r,Nord)
        side=inverse(side)
        putmarkers!(r,side)
    end
    moves!(r,Sud)
    moves!(r,West)
    moves_with_num!(r,Ost,num_hor)
    moves_with_num!(r,Nord,num_vert)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function putmarkers!(r::Robot, side::HorizonSide)
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

function moves_with_num!(r::Robot,side::HorizonSide, num::Integer)
    for i in 1:num
        move!(r,side)
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

mark_all(r)
