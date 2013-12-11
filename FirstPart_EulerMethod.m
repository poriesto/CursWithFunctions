function y_new = FirstPart_EulerMethod(a1, T, POINT_AMOUNT)
    
    global y;
    
    ITERATION_AMOUNT = 300;     %количество точек для первого графика.    
    x_t = 5;
    h   = 0.5;
    z1  = 0;
    z2  = 0;
    
    coeff_z1  = 120*a1/T.^2+6;
    coeff_z2  = 6*a1-120+48*a1/T;
    coeff_x_t = 120*a1/T.^2;
    %free_term - свободный член.
    free_term = coeff_x_t*x_t;

    for i = 1:ITERATION_AMOUNT

        z1(i+1) = z1(i) + h*z2(i);
        z2(i+1) = z2(i) + h*(x_t-z1(i)-0.4*T*z2(i))/T.^2;

        %y(i) = 306*z1(i) + 180*z2(i) - 300*x_t;
        %y(i) = (120*a1/T.^2+6)*z1(i) + (6*a1-120+48*a1/T)*z2(i) - (120*a1/T.^2)*x_t;
        y(i) = coeff_z1*z1(i) + coeff_z2*z2(i) - free_term;
        
    end;

%     figure
%     i = 1:ITERATION_AMOUNT;
%     plot(i,y);
%     title('Y теоретическое. график на 300 точек');
    
    %saveas(gcf, 'output', 'bmp');
    %оставляем из всех 300 точек только 50 (POINT_AMOUNT)
    j = 1;
    step_cycle = ITERATION_AMOUNT/POINT_AMOUNT;
    for i = 1:step_cycle:ITERATION_AMOUNT
        y_new(j) = y(i);   
        j = j + 1;
    end;
    
%     figure
%     i = 1:POINT_AMOUNT;
%     plot(i,y_new);
%     title('Y теоретическое. график на 50 точек (через каждые 6)');
    
end
