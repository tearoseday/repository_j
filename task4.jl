#прямоугольный треугольник
using HorizonSideRobots
function pyramide(r::Robot)
    move_angle_left!(r)        #перемещается в юго-западный угол
    lenght = moves!(r, Ost)    #длина
    hight = moves!(r, Nord)    #высота
    move_angle_left!(r)        #перемещается в юго-западный угол
    j=lenght+1
        for i in 1:hight       #маркируем один ряд
            while j-i != 0
                putmarker!(r)
                move!(r,Ost)
                j-=1
            end
            putmarker!(r)
            j=lenght+1
            back(r)            #возврат в начало ряда
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
