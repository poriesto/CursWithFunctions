%Часть 3. CF
function [CF, a1, T] = ThirdPart(y_teor, POINT_AMOUNT, h, EPSILON, ITERATION_AMOUNT)
	
    global y_noise;
    global x_noise;
    global y_exp;
    global delta_y;
    %global y_max;
    
    %y_max берем из 1 части.
    y_max = max(abs(y_teor));
    
    %delta_y = y max * Мю
    delta_y(1) = y_max*0.005;
    delta_y(2) = y_max*0.01; 
    delta_y(3) = y_max*0.02; 

    %Генератор случайных чисел. Треугольный шум.
    [y_noise(1, :), x_noise(1, :)] = RNG_Triangle(delta_y(1), POINT_AMOUNT);
    [y_noise(2, :), x_noise(2, :)] = RNG_Triangle(delta_y(2), POINT_AMOUNT);
    [y_noise(3, :), x_noise(3, :)] = RNG_Triangle(delta_y(3), POINT_AMOUNT);

%     y_exp(1, :) = y_teor + y_noise(1, :);
%     y_exp(2, :) = y_teor + y_noise(2, :);
%     y_exp(3, :) = y_teor + y_noise(3, :);
     
    y_exp(1, :) = y_teor + x_noise(1, :);
    y_exp(2, :) = y_teor + x_noise(2, :);
    y_exp(3, :) = y_teor + x_noise(3, :);
    
    i = 1:POINT_AMOUNT;
    s_exp1 = 'k';
    s_exp2 = 'g';
    s_exp3 = 'b';
    s_teor = 'r';
%     figure
%     plot(i, y_exp(1, :), s_exp1, i, y_exp(2, :), s_exp2);
%     title('Yexp1 - черный. Yexp2 - зеленый');
%     
%     figure
%     plot(i, y_exp(3, :), s_exp3, i, y_teor, s_teor);
%     title('Yexp3 - голубой. Yteor - красный');

    [CF(1,:), a1(1,:), T(1,:)] = Optimization_CF(y_exp(1,:), POINT_AMOUNT, h, EPSILON, ITERATION_AMOUNT);
    [CF(2,:), a1(2,:), T(2,:)] = Optimization_CF(y_exp(2,:), POINT_AMOUNT, h, EPSILON, ITERATION_AMOUNT);
    [CF(3,:), a1(3,:), T(3,:)] = Optimization_CF(y_exp(3,:), POINT_AMOUNT, h, EPSILON, ITERATION_AMOUNT);
    
    i = 1:ITERATION_AMOUNT;
    figure
    %plot(i, CF(1,:), s_exp1, i, CF(2,:), s_exp2, i, CF(3,:), s_exp3);
    plot(CF(1,:));
    title('CF1'); 
end
