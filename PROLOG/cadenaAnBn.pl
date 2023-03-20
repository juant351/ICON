mueve(e0,a,[],e0,[a]).
mueve(e0,a,X,e0,[a|X]).
mueve(e0,b,[a|Xs],e1,Xs).
mueve(e1,b,[a|Xs],e1,Xs).

transita(e1,[],[],eF):-
    !.
transita(Estado,[CabezaCad|Cad],X,EstadoFinal):-
    CabezaCad \= [],
    mueve(Estado,CabezaCad,X,EstadoInter,XInter),
    transita(EstadoInter,Cad,XInter,EstadoFinal).
transita(e0,[],[],eF):-
    !.

valida(Cadena,Resultado):-
    transita(e0,Cadena,[],EstadoFinal),
    EstadoFinal = eF,
    Resultado is 1,
    !.

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
    !,
    clause(A,B),
    solve(B).



