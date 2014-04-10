function takeOffDistance = calculateTakeOffDistance(A, rho, cl, cd, deltaT, m, thrust)

    %Inputs:
        %A = surface area of the wing (top view down)
        %rho = air density
        %cl = coefficient of lift
        %deltaT = time steps
        %m = mass of plane
        %thrust = max thrust of engine

    x0 = 0;                 %initial position
    currentTime = 0;        %current time
    a = 0;                  %initial acceleration
    g = 9.8;                %acceleration due to gravity
    currentVelocity = 0;    %sets start velocity
    drag = calculateDrag(); %calls calculateDrag function (below)
    
    function finalVelocity = calculateEndVelocity()
        %KE = .5(mv^2)
        finalVelocity = ((2*m*g)/(rho*A*cl))^.5;
    end
    endVelocity = calculateEndVelocity();
    
    hold on;
    while(currentVelocity < endVelocity)
        if(thrust >= drag)
            drag = calculateDrag();
            sigmaF = thrust - drag;
            a = sigmaF/m;
            x0 = calculateX(a);
            currentVelocity = calculateVelocity();
            currentTime = currentTime + deltaT;
            plot(currentTime, currentVelocity);
            plot(currentTime, sigmaF, 'r');
            plot(currentTime, x0, 'g');
        else
            disp('drag too high currentVelocity no longer increasing');
            break 
        end
    end
    
    
    function drag = calculateDrag()
        drag = .5*rho*A*cd*currentVelocity^2;
    end
    function velocity = calculateVelocity()
        velocity = currentVelocity + a*deltaT;
    end
    function x = calculateX(a)
        x = x0 + currentVelocity*deltaT + .5*a*deltaT^2;
    end
    
disp(x0)
end
