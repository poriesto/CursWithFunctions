%Часть 2. Оптимизация покоординатно.
function SecondPart_OptimizationCoordinate(function_name, h, EPSILON, ITERATION_AMOUNT, a, b)
	
    global x;
    global y;

    %Перем. для пропуска проверки условия на то, предыд. y min из последних трех или нет.
	change_coord = 1;
	%Для выхода из цикла, если кол-во. итераций больше ITERATION_AMOUNT.
	number_iteration = 1;

	change   = 1;
	constant = 2;
	i = 2;
    
	x(1,1) = 2;					%первая координата, первое значение.
	x(2,1) = 2;					%вторая координата, первое значение.
	x(1,2) = x(change,i-1) + h;	%первая координата, второе значение.
	x(2,2) = x(constant,i-1);	%вторая координата, второе значение.
	
	y(1)                   = EllipseFunct_or_FunctRosenbrock(function_name, x(1,1), x(2,1), a, b);
	new_value_of_function  = EllipseFunct_or_FunctRosenbrock(function_name, x(1,2), x(2,2), a, b);

	if new_value_of_function > y(1)		
		h = h* (-1);
		x(1,2) = x(change,i-1) + h;
		y(2) = EllipseFunct_or_FunctRosenbrock(function_name, x(change,i), x(constant,i), a ,b);
	
	else
		y(2) = new_value_of_function;
    end

	%Цикл пока модуль разности функций больше точности эпсилон и количество итераций меньше ITERATION_AMOUNT(10000).
	while (abs(y(i)-y(i-1)) > EPSILON && (number_iteration < ITERATION_AMOUNT)) 
		
		number_iteration = number_iteration + 1;
		i = i + 1;
		change_coord = change_coord + 1;

		%прибавляем шаг к первой координате.
		x(change,i) = x(change,i-1) + h;
		%вторую координату переписываем.
		x(constant,i) = x(constant,i-1);
		%находим значение функции от новых значений.
		new_value_of_function = EllipseFunct_or_FunctRosenbrock(function_name, x(1,i), x(2,i), a, b);

            %disp ('x(1,i)=');
            %disp (x(1,i));
            %disp ('x(2,i)=');
            %disp (x(2,i));

		%если функция от текущих значений больше функции от предыдущих, то h = h* (-1), ... иначе y(i) = new_value_of_function.	
		if new_value_of_function > y(i-1) 			
            
            %обнуляем последнее значение
            x(change,i) = NaN;
			i = i - 1;	%чтобы вернуться к предыдущему минимальному значению функции
			h = h* (-1);

			%Если после смены координаты, по которой шагаем сделали не меньше 3 точек, то делаем проверку min y из последних 3-х. значений. 
			if (change_coord >= 3) 

				%если функция от значений на предыдущем шаге меньше текущих и меньше чем на шаге i-2, то меняем координату перемещения.
				if y(i-1) >= y(i) 

					%После перемены координаты по которой шагаем - обнуляем change_coord.
					change_coord = 0;
					if (constant == 1) 
						constant = 2;
						change   = 1;
                   
					else 
						constant = 1;
						change   = 2;
                    end

                end
            end       

		else 
			y(i) = new_value_of_function;
        end
    end %конец цикла while
    

    %====================================Графическая часть====================================
    %построение графика 
    x_contour = -5:0.1:5; 
    y_contour = -5:0.1:5; 
    [X, Y] = meshgrid(x_contour, y_contour); 
    
    if strcmp(function_name, 'ELLIPSE') == 1
        title_plot = ('Функция Эллипса');
        Z = (X/a).^2 + (Y/b).^2;
        min_x = 0;
        min_y = 0;
        contour_amount = 50;
        
    elseif strcmp(function_name, 'ROSENBROCK') == 1
        title_plot = ('Функция Розенброка');
        Z = 100 * (Y - X.^2).^2 + (1 - X).^2;
        min_x = 1;
        min_y = 1;
        contour_amount = 200;
    end 
    
    %figure
    %mesh(X,Y,Z);
    figure
    contour(X, Y, Z, contour_amount); 
    %[C, h] = contour(X, Y, Z, contour_amount); 
    %clabel(C, h); 
    % отображение меток уровня
    hold on; 
    plot(x(1, :), x(2, :), '<-'); 
    %вывод точки минимума.
    %text(min_x, min_y,'•MINIMUM(1,1)')
    plot(min_x, min_y, 'r*');
    title(title_plot);
    text(min_x-0.2, min_y-0.4,'MIN')
    % выводначальной точки на график 
    text(x(1,1), x(2,1), 'A0', ...
        'BackgroundColor',[.7 .7 .7]); 
    % вывод решения на график 
    %text(x(1,i) - 4, x(2,i), ... 
    text(-4.9, -3.9, ... 
        char(['x1 = ' num2str(x(1,i))], ... 
        ['x2 = ' num2str(x(2,i))], ... 
        ['y = ' num2str(y(i))], ... 
        ['итераций - ' num2str(number_iteration)]), ...
        'BackgroundColor',[.7 .7 .7]);
end