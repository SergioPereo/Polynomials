%%Calcula el grado del polinomio con la lista de coeficientes
%% A es los coeficientes, coef es la lista de coficientes, y N es el
%% grado de nuestro arreglo

degree([A|Coef], N) :-
	A \= 0,
        length(Coef, N).

%Suma de polinomios
%Denominaci�n de variables.
%A es el coeficiente de la lista de coeficientes del polinomio
%Pol1, Pol2, Pol3 es una lita de coeficientes

sumaPol([],[],[]):- %La suma de dos polinomios vac�os da como resultado uno va
    !.
sumaPol(Pol1,[], Pol1):-
    !.
sumaPol([], Pol2, Pol2):-
    !.
%Suma de listas no vac�as.
sumaPol([A1|Pol1], [A2|Pol2], [A3|Pol3]) :-
    A3 is (A1)+(A2), %Agregemos a la cabeza de nuestra lista res la suma de la cabezas del poliniomio 1 y 2.
    sumaPol(Pol1,Pol2,Pol3). % Llamadas recursivas operar con las colas de los polinomios

cls :- write('\33\[2J').

main:-
    sumaPol([4,3,2,1],[3,0,5],X).
