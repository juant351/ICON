% JUAN TORRES VILORIA
% SIMULACRO. Ejercicio 3.
% Modificar vanilla del 2 (ahora de izq a dcha) para que muestre una
% traza.

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

pintaLlamada(A):-
    write('Call: '),
    write(A),
    nl.
pintaExit(A):-
    write('Exit: '),
    write(A),
    nl.

solve(true):-!.
solve((A,B)):-
    !,
    solve(A),
    solve(B).
solve(A):-
    predicate_property(A,built_in),
    !,
    call(A).
solve(A):-
    !,
    pintaLlamada(A),
    clause(A,B),
    solve(B),
    pintaExit(A).
















