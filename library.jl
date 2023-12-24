# Файл roblib.jl

"""
    moves!(r::Robot, side::HorizonSide)

-- перемещает Робота до упора в заданном направлении
"""
moves!(r::Robot, side::HorizonSide) = 
while isborder(r,side) 
    move!(r,side) 
end

"""
    moves!(r::Robot, side::HorizonSide, num_steps::Int)

-- перемещает Робота в заданном направлении на заданное число шагов (если на пути - перегородка, то - ошибка)
"""
moves!(r::Robot, side::HorizonSide, num_steps::Int) = 
for _ in 1:num_steps
    move!(r,side)
end

"""
    find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide)

-- останавливает робота у перегородки, которая ожидается с направления side_to_border, при движении робота "змейкой" в сторону перегородки (от упора до упора в поперечном этому напавлении). 

-- side_of_movement - начальное "поперечное" направление
"""
find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide) = 
while isborder(r,side_to_border)==false  
    if isborder(r,side_of_movement)==false
        move!(r,side_of_movement)
    else
        move!(r,side_to_border)
        side_of_movement=inverse(side_of_movement)
    end
end

"""
    inverse(side::HorizonSide)

-- возвращает сторону горизонта, противоположную заданной
"""
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))


"""
    putmarkers!(r::Robot, side::HorizonSide)

-- ставит маркеры, пермещая Робота до упора в заданном направлении (в начальной клетке маркер не ставится)    
"""
putmarkers!(r::Robot, side::HorizonSide) = 
while isborder(r,side)==false
    move!(r,side)
    putmarker!(r)
end

"""
    putmarkers!(r::Robor,side_of_movement::Horizonside,side_to_border::HorizonSide)

-- Ставит маркеры и перемещает Робота в направлении side_of_movement пока рядом с ним в направлении side_to_border имеется перегородка (эти два направления должны быть взаимно перпендикулярными) 
"""
putmarkers!(r::Robot,side_of_movement::HorizonSide,side_to_border::HorizonSide) = 
while isborder(r,side_to_border)==true
    move!(r,side_of_movement)
end
