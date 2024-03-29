%����� min CF. ����������� ���������� a1 � T.

function [CF, arg1, arg2] = Optimization_CF(y_exp, POINT_AMOUNT, h, EPSILON, ITERATION_AMOUNT)
    
    global x;
    %�����. ��� �������� �������� ������� �� ��, ������. y min �� ��������� ���� ��� ���.
	change_coord = 1;
	%��� ������ �� �����, ���� ���-��. �������� ������ ITERATION_AMOUNT.
	number_iteration = 1;

	change   = 1;
	constant = 2;
	i = 2;
    
	x(1,1) = 8;				 %a1. ������ ����������, ������ ��������.
	x(2,1) = 1;					 %T. ������ ����������, ������ ��������.
	x(1,2) = x(change, i-1) + h; %������ ����������, ������ ��������.
	x(2,2) = x(constant, i-1);	 %������ ����������, ������ ��������.
	
	y_model = FirstPart_EulerMethod(x(1,1), x(2,1), POINT_AMOUNT);
    %display(y_model);
    
    %CF_summand - CF ���������.
    for j=1:POINT_AMOUNT
		CF_summand(j) = (y_exp(1, j)-y_model(j)).^2;
        %fprintf('y_model(j)-y_exp(1, j) =  %d\n', (y_exp(1, j)-y_model(j)));
        %fprintf('CF_summand(j) =  %d\n', CF_summand(j));
	end;
    
    CF(1) = sum(CF_summand)/POINT_AMOUNT;
    
    y_model = FirstPart_EulerMethod(x(1,2), x(2,2), POINT_AMOUNT);

    for j=1:POINT_AMOUNT
		CF_summand(j) = (y_exp(1, j)-y_model(j)).^2;
        %fprintf('CF_summand(j) =  %d\n', CF_summand(j));
	end;
    
    new_value_of_CF = sum(CF_summand)/POINT_AMOUNT;
    
	if new_value_of_CF > CF(1)		
		h = h* (-1);
		x(1,2) = x(1, 2) + h;
        y_model = FirstPart_EulerMethod(x(1,2), x(2,2), POINT_AMOUNT);
        
        for j=1:POINT_AMOUNT
            CF_summand(j) = (y_exp(1, j)-y_model(j)).^2;
        end;

        CF(2) = sum(CF_summand)/POINT_AMOUNT;
	else
		CF(2) = new_value_of_CF;
    end

	%���� ���� ������ �������� ������� ������ �������� ������� � ���������� �������� ������ ITERATION_AMOUNT(10000).
	while (abs(CF(i)-CF(i-1)) > EPSILON && (number_iteration < ITERATION_AMOUNT)) 
	%while (number_iteration < ITERATION_AMOUNT)
		
		number_iteration = number_iteration + 1;
		i = i + 1;
		change_coord = change_coord + 1;

		%���������� ��� � ������ ����������.
		x(change,i) = x(change,i-1) + h;
		%������ ���������� ������������.
		x(constant,i) = x(constant,i-1);
		%������� �������� ������� �� ����� ��������.
        y_model = FirstPart_EulerMethod(x(1,i), x(2,i), POINT_AMOUNT);

        for j=1:POINT_AMOUNT
            CF_summand(j) = (y_model(j)-y_exp(1, j)).^2;
        end;

        new_value_of_CF = sum(CF_summand)/POINT_AMOUNT;
        
        %fprintf('x(1,i) =  %d\n', x(1,i));
        %fprintf('x(2,i) =  %d\n', x(2,i));

		%���� ������� �� ������� �������� ������ ������� �� ����������, �� h = h* (-1), ... ����� y(i) = new_value_of_function.	
		if new_value_of_CF > CF(i-1) 			
            
            %�������� ��������� ��������
            x(change,i) = NaN;
			i = i - 1;	%����� ��������� � ����������� ������������ �������� �������
			h = h* (-1);

			%���� ����� ����� ����������, �� ������� ������ ������� �� ������ 3 �����, �� ������ �������� min y �� ��������� 3-�. ��������. 
			if (change_coord >= 3) 

				%���� ������� �� �������� �� ���������� ���� ������ ������� � ������ ��� �� ���� i-2, �� ������ ���������� �����������.
				if CF(i-1) >= CF(i) 

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
			CF(i) = new_value_of_CF;
        end
        
        %fprintf('i =  %d\n', i);
    end %����� ����� while
    
    arg1 = x(1, i);
    arg2 = x(2, i);
    fprintf('arg1 =  %d\n', arg1);
    fprintf('arg2 =  %d\n', arg2);
    
    %====================================����������� �����====================================
    %���������� ������� 
%     x_contour = -5:0.1:5; 
%     y_contour = -5:0.1:5; 
%     [X, Y] = meshgrid(x_contour, y_contour); 
% 
%      
%     if strcmp(function_name, 'ELLIPSE') == 1
%         title_plot = ('������� �������');
%         Z = (X/a).^2 + (Y/b).^2;
%         min_x = 0;
%         min_y = 0;
%         contour_amount = 50;
%         
%     elseif strcmp(function_name, 'ROSENBROCK') == 1
%         title_plot = ('������� ����������');
%         Z = 100 * (Y - X.^2).^2 + (1 - X).^2;
%         min_x = 1;
%         min_y = 1;
%         contour_amount = 200;
%     else
%         contour_amount = 50;
%         Z = CF;       
%      end 
%     
%     %figure
%     %mesh(X,Y,Z);
%      figure
%      contour(X, Y, Z, contour_amount); 
%     [C, h] = contour(X, Y, Z, contour_amount); 
%     clabel(C, h); 
%     % ����������� ����� ������
%     hold on; 
%     plot(x(1, :), x(2, :), '<-'); 
%     %����� ����� ��������.
%     %text(min_x, min_y,'�MINIMUM(1,1)')
%     plot(min_x, min_y, 'r*');
%     title(title_plot);
%     text(min_x-0.2, min_y-0.4,'MIN')
%     % �������������� ����� �� ������ 
%     text(x(1,1), x(2,1), 'A0', ...
%         'BackgroundColor',[.7 .7 .7]); 
%     % ����� ������� �� ������ 
%     %text(x(1,i) - 4, x(2,i), ... 
%     text(-4.9, -3.9, ... 
%         char(['x1 = ' num2str(x(1,i))], ... 
%         ['x2 = ' num2str(x(2,i))], ... 
%         ['y = ' num2str(y(i))], ... 
%         ['�������� - ' num2str(number_iteration)]), ...
%         'BackgroundColor',[.7 .7 .7]);    
    
end