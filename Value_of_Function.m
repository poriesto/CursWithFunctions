%¬ычисление значени€ функции в зависимости от того аргуемент "+" или "-".
function y_triangle = Value_of_Function(argument, delta_y)

    x1 = 0;
    y1 = 1/delta_y;
    y2 = 0;

    %fprintf('argument = %d\n', argument);
    %значение по горизонтали (аргумента) больше или меньше нул€ 
    if argument > 0
        x2 = delta_y;       
    else
        x2 = -delta_y;       
    end;
    
    y_triangle = (argument - x1)*(y2 - y1)/(x2 - x1) + y1; 
     
    %fprintf('x2 = %d\n', x2);
    %fprintf('y_triangle = %d\n', y_triangle);
end