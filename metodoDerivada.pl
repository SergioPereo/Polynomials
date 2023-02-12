degree([A|Coef], N) :-
	A \= 0,
    length(Coef, N).

/*El metodo derivaPol es el metodo en el que se ingresa el polinomio inicial
y regresa como resultado la derivada del polinomio.
Este mismo calcula el grado del polinomio para saber hasta donde avanzar en el arreglo y lo ingresa
como parametro en el siguiente metodo y mandamos como parametro la cola para reducir el grado del polinomio ya que la derivada 
de una constante siempre será 0 por eso desde un inicio ya nos deshacemos de un valor y el nuevo polinomio sera un polinomio con 
grado menor.*/

derivaPol([A|Pol], NuevoPol):-
	length(Pol,N),
	deriva(Pol,N,N,NuevoPol).

/*Deriva es el metodo que ya hace el cambio en los coeficientes del polinomio.
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
	







