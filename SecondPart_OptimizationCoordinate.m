%����� 2. ����������� �������������.
function SecondPart_OptimizationCoordinate(function_name, h, EPSILON, ITERATION_AMOUNT, a, b)
	
    global x;
    global y;

    %�����. ��� �������� �������� ������� �� ��, ������. y min �� ��������� ���� ��� ���.
	change_coord = 1;
	%��� ������ �� �����, ���� ���-��. �������� ������ ITERATION_AMOUNT.
	number_iteration = 1;

	change   = 1;
	constant = 2;
	i = 2;
    
	x(1,1) = 2;					%������ ����������, ������ ��������.
	x(2,1) = 2;					%������ ����������, ������ ��������.
	x(1,2) = x(change,i-1) + h;	%������ ����������, ������ ��������.
	x(2,2) = x(constant,i-1);	%������ ����������, ������ ��������.
	
	y(1)                   = EllipseFunct_or_FunctRosenbrock(function_name, x(1,1), x(2,1), a, b);
	new_value_of_function  = EllipseFunct_or_FunctRosenbrock(function_name, x(1,2), x(2,2), a, b);

	if new_value_of_function > y(1)		
		h = h* (-1);
		x(1,2) = x(change,i-1) + h;
		y(2) = EllipseFunct_or_FunctRosenbrock(function_name, x(change,i), x(constant,i), a ,b);
	
	else
		y(2) = new_value_of_function;
    end

	%���� ���� ������ �������� ������� ������ �������� ������� � ���������� �������� ������ ITERATION_AMOUNT(10000).
	while (abs(y(i)-y(i-1)) > EPSILON && (number_iteration < ITERATION_AMOUNT)) 
		
		number_iteration = number_iteration + 1;
		i = i + 1;
		change_coord = change_coord + 1;

		%���������� ��� � ������ ����������.
		x(change,i) = x(change,i-1) + h;
		%������ ���������� ������������.
		x(constant,i) = x(constant,i-1);
		%������� �������� ������� �� ����� ��������.
		new_value_of_function = EllipseFunct_or_FunctRosenbrock(function_name, x(1,i), x(2,i), a, b);

            %disp ('x(1,i)=');
            %disp (x(1,i));
            %disp ('x(2,i)=');
            %disp (x(2,i));

		%���� ������� �� ������� �������� ������ ������� �� ����������, �� h = h* (-1), ... ����� y(i) = new_value_of_function.	
		if new_value_of_function > y(i-1) 			
            
            %�������� ��������� ��������
            x(change,i) = NaN;
			i = i - 1;	%����� ��������� � ����������� ������������ �������� �������
			h = h* (-1);

			%���� ����� ����� ����������, �� ������� ������ ������� �� ������ 3 �����, �� ������ �������� min y �� ��������� 3-�. ��������. 
			if (change_coord >= 3) 

				%���� ������� �� �������� �� ���������� ���� ������ ������� � ������ ��� �� ���� i-2, �� ������ ���������� �����������.
				if y(i-1) >= y(i) 

					%����� �������� ���������� �� ������� ������ - �������� change_coord.
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
    end %����� ����� while
    

    %====================================����������� �����====================================
    %���������� ������� 
    x_contour = -5:0.1:5; 
    y_contour = -5:0.1:5; 
    [X, Y] = meshgrid(x_contour, y_contour); 
    
    if strcmp(function_name, 'ELLIPSE') == 1
        title_plot = ('������� �������');
        Z = (X/a).^2 + (Y/b).^2;
        min_x = 0;
        min_y = 0;
        contour_amount = 50;
        
    elseif strcmp(function_name, 'ROSENBROCK') == 1
        title_plot = ('������� ����������');
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
    % ����������� ����� ������
    hold on; 
    plot(x(1, :), x(2, :), '<-'); 
    %����� ����� ��������.
    %text(min_x, min_y,'�MINIMUM(1,1)')
    plot(min_x, min_y, 'r*');
    title(title_plot);
    text(min_x-0.2, min_y-0.4,'MIN')
    % �������������� ����� �� ������ 
    text(x(1,1), x(2,1), 'A0', ...
        'BackgroundColor',[.7 .7 .7]); 
    % ����� ������� �� ������ 
    %text(x(1,i) - 4, x(2,i), ... 
    text(-4.9, -3.9, ... 
        char(['x1 = ' num2str(x(1,i))], ... 
        ['x2 = ' num2str(x(2,i))], ... 
        ['y = ' num2str(y(i))], ... 
        ['�������� - ' num2str(number_iteration)]), ...
        'BackgroundColor',[.7 .7 .7]);
end