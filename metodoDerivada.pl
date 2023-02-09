degree([A|Coef], N) :-
	A \= 0,
    length(Coef, N).

%
derivaPol([A|Pol], NuevoPol):-
	length(Pol,N),
	deriva(Pol,N,N,NuevoPol).

deriva([],_,_,[]):- !.

deriva([A1|Pol],Grado,Cont,[A2|NuevoPol]):-
	A2 is A1 * (Grado - Cont+1),
	NuevoCont is Cont - 1,
	deriva(Pol,Grado,NuevoCont,NuevoPol).
	







