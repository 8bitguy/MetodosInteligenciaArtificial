%MODELO ADALINE

clear all;
close all;
clc;

%% Borrar
datos=xlsread('prueba','Hoja1','A2:C5');
X1=datos(:,2);
X2=datos(:,1);
Y=datos(:,3);

%% M�NIMOS CUADRADOS
n=size(X1,1); %Cantidad de Datos
Xa= [ones(n,1)]; %Primer columna de Xa

%Construir Xa
for i=1:2 
    Xa=[Xa X1.^i X2 X1.*X2 X2.*X1.^2]; %bias (tiene la estructura del polinomio)
    Wmc=inv(Xa'*Xa)*Xa'*Y; %M�nimos cuadrados
    Yg_mc=Xa*Wmc; %Y testada estimada a trav�s de m�nimos cuadrados
    E=Y-Yg_mc; %Error
    J(i,1)=(1/2*n)*E'*E; %Funci�n de costo
    
end

figure(1);
plot(X,Y,'b.',X,Yg_mc,'r.');
figure(2);
plot(J,'b-');
xlabel('Grado del polinomio');
ylabel('J(W,X)');


Xapred=[ones(4,1)];
Xpred=[17; -1; 8; -5];
for i=1:4
    Xapred=[Xapred Xpred.^i]
end
Ypred=Xapred*Wmc

