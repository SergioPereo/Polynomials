%%Calcula el grado del polinomio con la lista de coeficientes
%% A es los coeficientes, coef es la lista de coficientes, y N es el
%% grado de nuestro arreglo

degree([A|Coef], N) :-
	A \= 0,
        length(Coef, N).
% ----------------------------------------------------------------------------------------
% Multiplicación de una constante por un polinomio Casos bases
coefPorPol([],_,[]):- %Multplicación de una lista vacía
	!.
coefPorPol(_,[],[]):- %Multiplicación de una constante vacía
	!.
coefPorPol([],[],[]):- %Multiplicación de listas vacías
	!.
coefPorPol(Coef, [A|Pol], [An|PolN]):-
	An is Coef * A,
	coefPorPol(Coef,Pol, PolN).
% -----------------------------------------------------------------------------------------
% Resta de polinomios
% Denominación de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lita de
% coeficientes Verificar [] - p(x)
restaPol([],[],[]):- %La resta de dos polinomios vacíos da como resultado uno vacío
    !.
restaPol(Pol1,[], Pol1):-
    !.
restaPol([], Pol2, Pol2):-
	coef_Por_Pol(-1,Pol2,_),
    !.
%Resta de listas no vacías.
restaPol([A1|Pol1], [A2|Pol2], [A3|Pol3]) :-
    A3 is (A1-A2), %Agregemos a la cabeza de nuestra lista res la suma de la cabezas del poliniomio 1 y 2.
    restaPol(Pol1,Pol2,Pol3). % Llamadas recursivas operar con las colas de los polinomios.
% -----------------------------------------------------------------------------------------
% Suma de polinomios
% Denominación de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lita de
% coeficientes
sumaPol([],[],[]):- %La suma de dos polinomios vacíos da como resultado uno va
    !.
sumaPol(Pol1,[], Pol1):-
    !.
sumaPol([], Pol2, Pol2):-
    !.
%Suma de listas no vacías.
sumaPol([A1|Pol1], [A2|Pol2], [A3|Pol3]) :-
    A3 is (A1+A2), %Agregemos a la cabeza de nuestra lista res la suma de la cabezas del poliniomio 1 y 2.
    sumaPol(Pol1,Pol2,Pol3). % Llamada recursiva para sumar las colas restantes de la lista de coeficientes de polinomios

cls :- write('\33\[2J').
