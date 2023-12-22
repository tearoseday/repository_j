using HorizonSideRobots
r=Robot("untitled.sit", animate=true)

function find_passage(r::Robot)
    side=Ost
    while isborder(r,Nord)==true # прохода сверху нет
        putmarker!(r)
        move_by_markers!(r,side)
        side=inverse(side)
    end
end

move_by_markers!(r::Robot,side::HorizonSide) = while ismarker(r) move!(r,side) end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))


find_passage(r)