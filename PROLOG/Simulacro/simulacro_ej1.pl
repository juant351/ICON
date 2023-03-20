% JUAN TORRES VILORIA
% SIMULACRO. Ejercicio 1.
% Autómata que reconoce cadenas a^n b^n c^n.

mueve(e0,a,[],[],e0,[a],[]).
mueve(e0,a,X,[],e0,[a|X],[]).
mueve(e0,b,X,[],e1,X,[b]).
mueve(e1,b,X,Y,e1,X,[b|Y]).
mueve(e1,c,[a|Xs],[b|Ys],e2,Xs,Ys).
mueve(e2,c,[a|Xs],[b|Ys],e2,Xs,Ys).

transita(e2,[],[],[],eF):-!.
transita(Estado,[CabezaCad|Cad],X,Y,EstadoFinal):-
    CabezaCad \= [],
    mueve(Estado,CabezaCad,X,Y,EstadoInter,XInter,YInter),
    transita(EstadoInter,Cad,XInter,YInter,EstadoFinal).
transita(e0,[],[],[],eF).

valida(Cadena, CadenaFinal):-
    transita(e0,Cadena,[],[],EstadoFinal),
    EstadoFinal = eF,
    CadenaFinal is 1,
    !.
