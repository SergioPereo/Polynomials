%%Calcula el grado del polinomio con la lista de coeficientes
%% A es los coeficientes, coef es la lista de coficientes, y N es el
%% grado de nuestro arreglo

degree([A|Coef], N) :-
	A \= 0,
        length(Coef, N).

pol(Coef, Deg, Deg, [Coef]):-!.

pol(Coef, Deg, I, [0|Pol]):-
	NI is I+1,
	pol(Coef, Deg, NI, Pol).

pol(Coef, Deg, Pol):-
	pol(Coef, Deg, 0, Pol).
% -------------------------------------------------------------------------
% Suma de polinomios
% Denominación de variables. A es el coeficiente de
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
coef_por_pol(_,[],[]):- %Multplicaci�n de una lista vac�a
	!.
coef_por_pol(Alpha, [A|Pol], [An|PolN]):-
	An is Alpha * A,
	coef_por_pol(Alpha,Pol, PolN).

% -----------------------------------------------------------------------------------------
%Resta de polinios
% Denominaci�n de variables. A es el coeficiente de
% la lista de coeficientes del polinomio Pol1, Pol2, Pol3 es una lista
% de coeficientes
resta_pol(Pol1,Pol2,PolRes):-
	coef_por_pol(-1, Pol2, Pol2Inv),
	suma_pol(Pol1,Pol2Inv,PolRes).

% -----------------------------------------------------------------------------------------
% -------- PRODUCTO
% Si B es vac�o, el producto es vac�o.
% producto_pol(i, i, o):
producto_pol(_,[],[]):-
	!.
% Si son no vac�os
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
 * Genera un texto en base al coeficiente y grado del t�rmino.
 *
 */
beautify(0,0,"0"):-!.
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
p * To String
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


%to_string()
to_string(Pol):-
	to_string(Pol,LoT,0),
	exclude(are_the_same(""),LoT,[LastTerm|FilteredLoT]),
	print_lot(FilteredLoT),
	write(LastTerm),nl.

/*El metodo derival es el metodo en el que se ingresa el polinomio inicial
y regresa como resultado la derivada del polinomio.
Este mismo calcula el grado del polinomio para saber hasta donde avanzar en el arreglo y lo ingresa
como parametro en el siguiente metodo y mandamos como parametro la cola para reducir el grado del polinomio ya que la derivada 
de una constante siempre será 0 por eso desde un inicio ya nos deshacemos de un valor y el nuevo polinomio sera un polinomio con 
grado menor.*/

deriva([_|Pol], NuevoPol):-
	length(Pol,N),
	deriva(Pol,N,N,NuevoPol).

/*El siguiente metodo ya hace el cambio en los coeficientes del polinomio.
Tiene como caso base que esten vacios los dos polinomios que regrese el metodo deriva
*/


deriva([],_,_,[]):- !.

/*Lo que hace el metodo es recorrer desde el inicio del arreglo con un contador para poder multiplicar los coeficientes del polinomio
original e ingresarlos al nuevo polinomio siendo contruido y así sucesivamente hasta llegar al caso base
*/

deriva([A1|Pol],Grado,Cont,[A2|NuevoPol]):-
	A2 is A1 * (Grado - Cont+1),
	NuevoCont is Cont - 1,
	deriva(Pol,Grado,NuevoCont,NuevoPol).

compose([Term], PolB, PolC):-
	pol(0,0,C),
	producto_pol(PolB,C,Product),
	suma_pol([Term],Product,PolC).

compose([Term|PolA], PolB, PolC):-
	compose(PolA, PolB, C),
	producto_pol(PolB,C,Product),
	suma_pol([Term],Product,PolC).

main:-
	pol(0,0,Zero),
	pol(4,3,P1),
	pol(3,2,P2),
	pol(1,0,P3),
	pol(2,1,P4),
	suma_pol(P1,P2,P1P2),
	suma_pol(P1P2,P3,P1P2P3),
	suma_pol(P1P2P3,P4,P),
	pol(3,2,Q1),
	pol(5,0,Q2),
	suma_pol(Q1,Q2,Q),
	suma_pol(P,Q,R),
	producto_pol(P,Q,S),
	compose(P,Q,T),
	write("zero(x)\t\t\t= "),to_string(Zero),nl,
	write("p(x)\t\t\t= "),to_string(P),nl,
	write("q(x)\t\t\t= "),to_string(Q),nl,
	write("p(x) + q(x)\t\t= "),to_string(R),nl,
	write("p(x) * q(x)\t\t= "),to_string(S),nl,
	write("p(q(x))\t\t\t= "),to_string(T),nl,
	write("0 - p(x)\t\t= "),resta_pol(Zero,P,ZP),to_string(ZP),nl,
	write("p(3)\t\t\t= "),evaluate(P,3,Evaluation),write(Evaluation),nl,
	write("p'(x)\t\t\t= "),deriva(P,DP),to_string(DP),nl,
	write("p''(x)\t\t\t= "),deriva(DP,DDP),to_string(DDP),nl.


cls :- write('\33\[2J').


