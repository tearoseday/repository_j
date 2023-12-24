using HorizonSideRobots
r=Robot("untitled.sit",animate=true)
function mark_corners!(r::Robot)
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West)==false
        push!(num_steps, along_numsteps!(r,West))
        push!(num_steps,along_numsteps!(r,Sud))
    end
    for side in (Nord, Ost, Sud, West)
        along_numsteps!(r,side)
        putmarker!(r)
    end
    i=1
    k=length(num_steps)
    i +=Int(isodd(k))

    for n in 1:k
        i=i+1
        t=isodd(i)
        side=Nord
        if t
            side=Ost
        end
        go_along!(r,side,num_steps[k-n+1])
    end 
end
function along_numsteps!(r::Robot,side::HorizonSide) :: Int
    n=0
    while isborder(r,side)==false
        move!(r,side)
        n+=1
    end 
    return n
end

function go_along!(r::Robot,side::HorizonSide,n::Int)::Nothing
    while n>0
        move!(r,side)
        n=n-1
    end
end