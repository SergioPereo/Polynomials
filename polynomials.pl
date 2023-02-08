%%Calcula el grado del polinomio con la lista de coeficientes
%% A es los coeficientes, coef es la lista de coficientes, y N es el
%% grado de nuestro arreglo

degree([A|Coef], N) :-
	A \= 0,
        length(Coef, N).
% -------------------------------------------------------------------------
% Suma de polinomios
% DenominaciÃ³n de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lista
% de coeficientes
suma_pol(Pol1,[],Pol1):-
	!.
suma_pol([], Pol2, Pol2):-
	!.
suma_pol([A1|Pol1], [A2|Pol2], [A3|Pol3]) :-
	A3 is (A1+A2), %Agregemos a la cabeza de nuestra lista res la suma de la cabezas del poliniomio 1 y 2.
	suma_pol(Pol1,Pol2,Pol3). % Llamada recursiva para sumar las colas restantes de la lista de coeficientes de polinomios
% ----------------------------------------------------------------------------------------
% Producto escalar alpha * [An,...,An-1]
coef_por_pol(_,[],[]):- %Multplicación de una lista vacía
	!.
coef_por_pol(Alpha, [A|Pol], [An|PolN]):-
	An is Alpha * A,
	coef_por_pol(Alpha,Pol, PolN).

% -----------------------------------------------------------------------------------------
%Resta de polinios
% Denominación de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lista
% de coeficientes
resta_pol(Pol1,Pol2,PolRes):-
	coef_por_pol(-1, Pol2, Pol2Inv),
	suma_pol(Pol1,Pol2Inv,PolRes).

% -----------------------------------------------------------------------------------------
% -------- PRODUCTO
% Si B es vacío, el producto es vacío.
% producto_pol(i, i, o):
producto_pol(_,[],[]):-
	!.
% Si son no vacíos
producto_pol(A,[Cb|B], C) :-
	producto_pol(A,B, Rec), %quitamos cabeza de B y llamamos recursivamente.
	coef_por_pol(Cb, A, Esc), %calculamos el prod. Esc con la cabeza de B.
	suma_pol(Esc, [0|Rec], C), %sumamos ambos resultados anteriores en C.
	!.

/*
 * Evaluate
 * Recibe un polinomio y un valor a evaluar X y guarda el resultado de
 * la evaluacion en la variable Y
 *
 */
evaluate([],_,0,_).
evaluate([Term|Pol],X,P,Deg):-
	NewDeg is Deg+1,
	evaluate(Pol,X,LastP,NewDeg),
	P is (Term+X*LastP).
evaluate(Pol,X,Y):-
	evaluate(Pol,X,Y,0).

/*
 * Beautify
 * Genera un texto en base al coeficiente y grado del término.
 *
 */
beautify(0,_,""):-!.
beautify(Coefficient,0,Text):-atom_string(Coefficient,Text),!.
beautify(Coefficient,Deg,Text):-atomics_to_string([Coefficient,"x^",Deg],Text).

%Funcion que checa que X y Y sean iguales.
%Se usa en to_string para filtrar los terminos que esten vacios.
are_the_same(X,Y):-X==Y.

/*
 * Print LoT
 * Imprime la lista de terminos.
 *
 */
print_lot([]).
print_lot([Term|LoT]):-
	print_lot(LoT),
	write(Term),write(" + ").
/*
 * To String
 * Recibe un polinomio y lo imprime de manera "bonita".
 *
 */
to_string([],[],_):-!.
% Crea el texto de cada termino y lo almacena en la variable
% LoT:List Of Terms.
to_string([Coefficient|Pol],[Term|LoT],Deg):-
	NewDeg is Deg+1,
	to_string(Pol,LoT,NewDeg),
	beautify(Coefficient,Deg,Term).
% Inicia la funcion recursiva, filtra los terminos vacios e imprime los
% terminos.
to_string(Pol):-
	to_string(Pol,LoT,0),
	exclude(are_the_same(""),LoT,[LastTerm|FilteredLoT]),
	print_lot(FilteredLoT),
	write(LastTerm),nl.


cls :- write('\33\[2J').


