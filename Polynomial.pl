% Suma de polinomios
% Denominación de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lita de
% coeficientes
sumaPol(Pol1,[],Pol1):-
	!.
sumaPol([], Pol2, Pol2):-
	!.
sumaPol([A1|Pol1], [A2|Pol2], [A3|Pol3]) :-
    A3 is (A1+A2), %Agregemos a la cabeza de nuestra lista res la suma de la cabezas del poliniomio 1 y 2.
    sumaPol(Pol1,Pol2,Pol3). % Llamada recursiva para sumar las colas restantes de la lista de coeficientes de polinomios
% ----------------------------------------------------------------------------------------
% Produco esacalar α * [An,...,An-1]
coefPorPol(_,[],[]):- %Multplicación de una lista vacía
	!.
coefPorPol(Alpha, [A|Pol], [An|PolN]):-
	An is Alpha * A,
	coefPorPol(Alpha,Pol, PolN).

% -----------------------------------------------------------------------------------------

% -----------------------------------------------------------------------------------------
cls :- write('\33\[2J').
