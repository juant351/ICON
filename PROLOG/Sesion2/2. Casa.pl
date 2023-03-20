% Definir operaciones & y --->
:-op(40, xfy, &).
:-op(50, xfy, --->).

% Meta interprete
solve(true):-!.
solve((A & B)):-!, solve(A), solve(B).
solve(A):-(B ---> A), solve(B).


% BASE DEL CONOCIMIENTO

% Encendido de bombillas
light(L) & ok(L) & live(L) ---> lit(L).

% Conexion de cables
connected_to(W, W1) & live(W1) ---> live(W).

% Tension del cable externo
true ---> live(outside).

% Funcionamiento correcto de todos los componentes
true ---> ok(l1).
true ---> ok(l2).
true ---> ok(s1).
true ---> ok(s2).
true ---> ok(s3).
true ---> ok(cb1).
true ---> ok(cb2).

% Bombillas
true ---> light(l1).
true ---> light(l2).

% Posicion de los interruptores
true ---> down(s1).
true ---> up(s2).
true ---> up(s3).

% Conexion segun interruptores
up(s1) & ok(s1) ---> connected_to(w1, w3).
down(s1) & ok(s1) ---> connected_to(w2, w3).

up(s2) & ok(s2) ---> connected_to(w0, w1).
down(s2) & ok(s2) ---> connected_to(w0, w2).

up(s3) & ok(s3) ---> connected_to(w4, w3).

% Conexion por diferenciales
ok(cb1) ---> connected_to(w3 , w5).
ok(cb2) ---> connected_to(w6 , w5).

% Conexion de enchufes
true ---> connected_to(p1, w3).
true ---> connected_to(p2, w6).

% Conexion de bombillas
true ---> connected_to(l1, w0).
true ---> connected_to(l2, w4).

% Conexion con el cable externo
true ---> connected_to(w5, outside).