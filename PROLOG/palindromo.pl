% TORRES VILORIA JUAN.
% Metaintérprete para confirmar cadenas de palíndromos.

mover(e0,X,[],e0,[X]).
mover(e0,X,Y,e0,[X|Y]).
mover(e0,X1,Y,e1,Y).
mover(e1,X1,Y,e1,Y).
mover(e1,X,[X|Ys],e2,Ys).
mover(e2,X,[X|Ys],e2,Ys).

transita(e2,[],[],eF):-
    !.
transita(Estado,[CabezaCad|Cad],Pila,EstadoFinal):-
    CabezaCad \= [],
    mover(Estado,CabezaCad,Pila,EstadoInter,PilaInter),
    transita(EstadoInter,Cad,PilaInter,EstadoFinal).
transita(e0,[],[],eF):-
    !.

valida(Cadena, Resultado):-
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

solve(true,_):-
    !.
solve((A,B),Prf):-
    solve(A,Prf),
    solve(B,Prf).
solve(A):-
    predicate_property(A,built_in),
    !,
    call(A).
solve(A,Prf):-
    pintarLlamada(A),
    clause(A,B),
    X is Prf-1,
    X >= 0,
    solve(B,X),
    pintarExit(A).




