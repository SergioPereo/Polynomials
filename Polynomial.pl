%%Calcula el grado del polinomio con la lista de coeficientes
%% A es los coeficientes, coef es la lista de coficientes, y N es el
%% grado de nuestro arreglo

degree([A|Coef], N) :-
	A \= 0,
        length(Coef, N).
% -------------------------------------------------------------------------
% Suma de polinomios
% Denominación de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lista
% de coeficientes
sumaPol(Pol1,[],Pol1):-
	!.
sumaPol([], Pol2, Pol2):-
	!.
sumaPol([A1|Pol1], [A2|Pol2], [A3|Pol3]) :-
    A3 is (A1+A2), %Agregemos a la cabeza de nuestra lista res la suma de la cabezas del poliniomio 1 y 2.
    sumaPol(Pol1,Pol2,Pol3). % Llamada recursiva para sumar las colas restantes de la lista de coeficientes de polinomios
% ----------------------------------------------------------------------------------------
% Produco escalar a * [An,...,An-1]
coefPorPol(_,[],[]):- %Multplicación de una lista vacía
	!.
coefPorPol(Alpha, [A|Pol], [An|PolN]):-
	An is Alpha * A,
	coefPorPol(Alpha,Pol, PolN).

% -----------------------------------------------------------------------------------------
%Resta de polinios
% Denominación de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lista
% de coeficientes
restaPol(Pol1,Pol2,PolRes):-
    coefPorPol(-1, Pol2, Pol2Inv),
    sumaPol(Pol1,Pol2Inv,PolRes).

% -----------------------------------------------------------------------------------------
cls :- write('\33\[2J').

