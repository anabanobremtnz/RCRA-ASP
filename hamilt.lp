node(1..4).
edge(1,2). edge(2,3). edge(2,4).
edge(3,1). edge(3,4). edge(4,3). edge(4,1).

% Generar conjuntos de aristas
{in(X,Y)} :- edge(X,Y).

% No puedes salir a dos nodos diferentes
:- in(X,Y), in(X,Y'), Y != Y'.

% No puedes entrar a dos nodos diferentes
:- in(X,Y), in(X',Y), X != X'.

% reach(X,Y) = Desde X puedo llegar a Y
% minnodo(M) :- #min{X:vtx(X)}=M. <--------- para o yingyang
% en rach y e reach z
reach(X,Y) :- in(X,Y).
reach(X,Z) :- reach(X,Y), in(Y,Z).

% Todos conectados
:- node(X), node(Y), not reach(X,Y).
#show in/2.