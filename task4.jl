using HorizonSideRobots
r=Robot("untitled.sit", animate=true)
include("lib.jl")

function pyramide(r::Robot)
    move_angle_left!(r)
    lenght = moves!(r, Ost)
    hight = moves!(r, Nord)
    move_angle_left!(r)
    j=lenght+1
        for i in 1:hight
            while j-i != 0
                putmarker!(r)
                move!(r,Ost)
                j-=1
            end
            putmarker!(r)
            j=lenght+1
            back(r)
            move!(r,Nord)
        end
end

function move_angle_left!(r::Robot) 
    for side in (Sud, West)
        while isborder(r, side) == false
            move!(r, side)
        end
    end
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function back(r::Robot)
    while isborder(r,West) == false
        move!(r,West)
    end
end

pyramide(r)