function takeOffDistance = calculateTakeOffDistance(A, rho, cl, cd, deltaT, m, thrust)
    x0 = 0;
    currentTime = 0;
    a = 0;
    g = 9.8;
    currentVelocity = 0;
    drag = calculateDrag();
    
    function finalVelocity = calculateEndVelocity()
        finalVelocity = ((2*m*g)/(rho*A*cl))^.5;
    end
    endVelocity = calculateEndVelocity();
    
    hold all;
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
