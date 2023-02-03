populate(Coef,0,Pol,NewPol):-
       append(Pol, [Coef], NewPol).

populate(Coef,Cont,Pol,NewPol):-
       append(Pol, [0], ActualPol),
       NewCont is Cont-1,
       populate(Coef,NewCont,ActualPol,NewPol).


polynomial(Coef, Grad, Pol):-
       Grad>=0,
       populate(Coef, Grad, [], NewPol),
       Pol = NewPol.


/*suma().
resta().
mult().
dif().
comp().*/
