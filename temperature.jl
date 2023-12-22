##Дано: робот в юго-западном углу. Результат: подсчитана средняя температура замаркированных клеток поля
using HorizonSideRobots
function mean_temperature!(robot)
## робот в өго-западном углу
    side = Ost
    N, sum_tmp = temperatures_row!(robot, side)
    while !isborder(robot, Nord)
        HorizonSideRobots.move!(robot, Nord)
        n, s = temperatures_row!(robot, side)
        side = inverse(side)
        N += n
        sum_tmp += s
    end
    return sum_tmp/N
end
function temperatures_row!(robot, side)
    if ismarker(robot)
        n, s = 1, temperature(robot)
    else
        n, s = 0, 0
    end
    while !isborder(robot, side)
        HorizonSideRobots.move!(robot, side)
        if ismarker(robot)
            n += 1
            s += temperature(robot)
        end
    end
    return n, s
end
function moves!(robot, side :: HorizonSide, num_steps :: Integer)
    for _ in 1:num_steps
        HorizonSideRobots.move!(robot, side)
    end
end
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

