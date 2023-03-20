% TORRES VILORIA, JUAN.
% Comprobar que en una cadena hay el mismo número de 'a' que de
% 'b',usando sólo una pila. [a,a,b,b].

mover(e0,a,[],e0,[a]).
mover(e0,a,X,e0,[a|X]).
mover(e0,b,[a|Xs],e1,Xs).
mover(e1,b,[a|Xs],e1,Xs).

transita(e1,[],[],eF):-
    !.
transita(Estado,[CabezaCad|Cad],X,EstadoFinal):-
    CabezaCad \= [],
    mover(Estado,CabezaCad,X,EstadoInter,XInter),
    transita(EstadoInter,Cad,XInter,EstadoFinal).
transita(e0,[],[],eF):-
    !.

verifica(Cadena, Resultado):-
    transita(e0,Cadena,[],EstadoFinal),
    EstadoFinal = eF,
    Resultado is 1,
    !.

pintarLlamada(A):-
    write('Call: '),
    write(A),
    nl.

pintarExit(A):-
    write('Exit: '),
    write(A),
    nl.

solve(true):-
    !.
solve((A,B)):-
    !,
    solve(A),
    solve(B).
solve(A) :-
    predicate_property(A,built_in),
    !,
    call(A).
solve(A):-
    pintarLlamada(A),
    clause(A,B),
    solve(B),
    pintarExit(A).
