%����� 3. 
%��������� ��������� �����. �� ������ y_noise.
%Random number generator. ����������� ���.
function [y_noise, x_noise] = RNG_Triangle(delta_y, POINT_AMOUNT)

    global j;
    %global y_noise;
    %global x_noise;
    
    j = 1;
    
    %for i = 1:POINT_AMOUNT
    while j <= POINT_AMOUNT
        % Generate values from the uniform distribution on the interval [a, b]:
        %r = a + (b-a).*rand(100,1);
        
        %a - �� �������������� ������ - ��������. ���������� ����� �� -delta_y �� delta_y.
        a = -delta_y + (delta_y-(-delta_y)).*rand();  
        %b - �� ������������ ������ - �������. ���������� ����� �� 0 �� 1/delta_y.
        b = 0 + (1/delta_y-0).*rand();
        
        %fprintf('a = %d\n', a);
        %fprintf('b = %d\n', b);
        %fprintf('Value_of_Function(a, delta_y)  = %d\n', Value_of_Function(a, delta_y));

        if Value_of_Function(a, delta_y) > b
            %����� ������
            y_noise(j) = b;
            x_noise(j) = a;
            %fprintf('y_noise(j) = %d\n', y_noise(j));

            j = j + 1;
        end;

    end;

    %figure;
	%������ �����������.
    hist(x_noise);
    
end