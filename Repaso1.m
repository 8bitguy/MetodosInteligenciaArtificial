%% Problema 2 Tarea 1: Adaline
clear all;
close all;
clc;

%% 
data = xlsread('CCPP.xlsx');
X = data(:, 1:4);
Y = data(:, 5);

%% M�NIMOS CUADRADOS
n=size(Y,1); %Cantidad de Datos
Xa= [ones(n,1)]; %Primer columna de Xa

%Construir Xa
for i=1:2
    grado=i;
    Xa = func_polinomio([X],i); %bias (tiene la estructura del polinomio)
    Wmc=inv(Xa'*Xa)*Xa'*Y; %M�nimos cuadrados
    Yg_mc=Xa*Wmc; %Y testada estimada a trav�s de m�nimos cuadrados
    E=Y-Yg_mc; %Error
    J(i,1) = E'*E/(2*n) %Funci�n de costo 
    plot(J,'b-');
end


subplot(2,1,1);
plot(Xa,Y,'b.',Xa,Yg_mc,'r.');
subplot(2,1,2)
plot(J,'b-');
xlabel('Grado del polinomio');
ylabel('J(W,X)');
J(grado);

%%
Xpred=[38.57; 6.249; 0; 0.59; 1.7; 0; 2; 0];
XaTest = func_polinomio(Xpred, 2);
Yn = XaTest*Wmc

