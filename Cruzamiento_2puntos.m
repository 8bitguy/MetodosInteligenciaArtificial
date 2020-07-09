clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla


nbits=8; %Numeros de bits
np=8; %Numero de pobladores

clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla

 
xmax=50; %valor mayor el intervalo
xmin=-50; %valor menor del intervalo
tp=.01; %n�mero de pasos

nbits=ceil(log2((xmax-xmin+1)/tp)); %Numero de bits (redondeado)
np=32; %Numero de pobladores

 %%
%Generar poblaci�n

x1 = randi([0, 2^nbits-1], np, 1); %Generar la poblaci�n de enteros inicial 
x1real=((xmax-xmin)/(2^nbits-1))*x1 + xmin; %Conversion de enteros a reales

for n=1:1000 %N�mero de Generaciones
    y= -(x1real+40.2).^2+100; %Al usar . potencia se hace con todos los elementos.
    
    yprom(n)=mean(y);
    
    %Cromosoma 
    cromosoma=sortrows([y x1 x1real],1); %Ordenar

    %Selecci�n (En el caso de Maximizar se toman los mayores) 
    padresbin=de2bi(cromosoma(np/2+1:end, 2),nbits);
 
    %CRUZAMIENTO 2 PUNTOS
    for k=1:(np/4)
            p1 = randi([2,nbits-2]);
            p2 = randi([p1+1,nbits-1]);
            hijobin(2*k-1,:)=[padresbin(2*k-1,1:p1) padresbin(2*k,p1+1:p2) padresbin(2*k-1,p2+1:nbits)];
            hijobin(2*k,:)=[padresbin(2*k,1:p1) padresbin(2*k-1,p1+1:p2) padresbin(2*k,p2+1:nbits)];
        end

    %Mutaci�n
    m=rand(); %N�mero aleatorio
    if m >= 0.90
        nhijo=randi(np/2); %Numero de hijo
        bit=randi(nbits); %bit a mutar
        if hijobin(nhijo, bit)==1
           hijobin(nhijo, bit)=0;
        else
           hijobin(nhijo, bit)=1;     
        end  
    end

    %Reemplazo
    hijoentero=bi2de(hijobin); %Convierte a entero
    hijoreal=((xmax-xmin)/(2^nbits-1))*hijoentero + xmin; %Convertir hijos reales a reales
    x1=[cromosoma(np/2+1:end,2); hijoentero]; %Nueva generaci�n 
    x1real=[cromosoma(np/2+1:end,3); hijoreal];

       
end 
plot(yprom)
y= -(x1real+40.2).^2+100;
cromosoma=[y x1 x1real];
[val, ind]=max(y);
disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) ' y= '  num2str(val)])
