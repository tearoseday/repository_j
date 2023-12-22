using HorizonSideRobots
r=Robot("untitled.sit",animate=true)


function way_to_edge!(r::Robot)
    numsteps_sud=0
    while !isborder(r, Sud)
        move!(r, Sud)
        numsteps_sud+=1
    end
    numsteps_west=0
    while !isborder(r, West)
        move!(r, West)
        numsteps_west+=1
    end
    return (numsteps_west,numsteps_sud)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

function go_to_initial_position!(r::Robot,initial_position)
    numsteps_west=initial_position[1]
    numsteps_sud=initial_position[2]
    for n in 1:numsteps_west
        move!(r,Ost)
    end
    for n in 1:numsteps_sud
        move!(r,Nord)
    end
end

function task10!(r::Robot)
    side =Ost
    initial_position=way_to_edge!(r)
    temp_sum=0
    while !isborder(r,side)
        move!(r,side)
    end
    side=inverse(side)
    while !isborder(r,Nord)
        move!(r,Nord)
        while !isborder(r,side)
            if ismarker(r)
                temp_sum+=temperature(r)
            end
            move!(r,side)
        end
        side=inverse(side)
    end
    way_to_edge!(r)
    go_to_initial_position!(r,initial_position)
    return temp_sum
end

print(task10!(r))