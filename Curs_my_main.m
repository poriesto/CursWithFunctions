clear all;
clc;

global x;
global y;
%���������� � 3 �����.
global y_exp;
%global j;
global y_noise;
global x_noise;
global delta_y;

ITERATION_AMOUNT = 1000;
EPSILON          = 0.0001;	%��������
h                = 0.2;		%���
POINT_AMOUNT     = 50;      %���������� �����

%a � b - �������� �������� ��� �-��. �������.
a = 3;
b = 2;

%�������� �������� ���������� ������� W(s).
a1 = 10;
T  = 2;

ELLIPSE    = 'ELLIPSE';
ROSENBROCK = 'ROSENBROCK';

%����� 1. �����.
y_teor = FirstPart_EulerMethod(a1, T, POINT_AMOUNT);

%����� 2. ����������� �������������.
%SecondPart_OptimizationCoordinate(ELLIPSE, h, EPSILON, ITERATION_AMOUNT, a, b);
%SecondPart_OptimizationCoordinate(ROSENBROCK, h, EPSILON, ITERATION_AMOUNT, a, b);

%����� 3.
[CF, new_a1, new_T] = ThirdPart(y_teor, POINT_AMOUNT, h, EPSILON, ITERATION_AMOUNT);
