%Функция для вычисления значения ф-ии. F(x1, x2) по Розенброку или по ф-ии. Эллипса.
function y = EllipseFunct_or_FunctRosenbrock(function_name, x_0_i, x_1_i, a, b) 
    
    if strcmp(function_name, 'ROSENBROCK') == 1
	%if function_name == 'ROSENBROCK' 
    %if eq(function_name, 'ROSENBROCK')
        %x0i_2 = x_0_i*x_0_i;
		%y = (100 * (x0i_2 - x_1_i)*(x0i_2 - x_1_i) + (1 - x_0_i)*(1 - x_0_i));	
        y = 100 * (x_1_i - x_0_i.^2).^2 + (1 - x_0_i).^2;	
        return
        
    elseif strcmp(function_name, 'ELLIPSE') == 1    
    %elseif function_name == 'ELLIPSE' 	
    %elseif eq(function_name, 'ELLIPSE')
        %y = x_0_i*x_0_i/(a*a) + x_1_i*x_1_i/(b*b);	
        y = x_0_i.^2/a.^2 + x_1_i.^2/b.^2;	
        return 
	else 
		y = -1;
        return 
    end
end