function FirstPart_EulerMethod
    
    global y;
    x_t = 5;
    h  = 0.5;
    z1 = 0;
    z2 = 0;

    for t = 1:300

        z1(t+1) = z1(t) + h*z2(t);
        z2(t+1) = z2(t) + h*(5-z1(t)-0.8*z2(t))/4;

        %y(t) = 6*z1(t)-60*z2(t)-300*(5-z1(t)-0.8*z2(t));
        y(t) = 306*z1(t) + 180*z2(t) - 300*x_t;
        
    end;

    t = 1:300;
    plot(t,y);

end
