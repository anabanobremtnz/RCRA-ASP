vtx(1..4).
edge(1,2,5). edge(2,3,5). edge(2,4,5).
% Poñer outro valor¿? edge(3,1). edge(3,4). edge(4,3). edge(4,1).

% Generar conjuntos de aristas
edge(X,Y) :- edge(X,Y,_).
{in(X,Y)} :- edge(X,Y).

% No puedes salir a dos nodos diferentes
%:- in(X,Y), in(X,Y'), Y != Y'.
:- in(X,Y), in(X,Y'), Y<Y'.

% No puedes entrar a dos nodos diferentes
%:- in(X,Y), in(X',Y), X != X'.
:- in(X,Y), in(X',Y), X<X'.

% reach(X,Y) = Desde X puedo llegar a Y
% minnodo(M) :- #min{X:vtx(X)}=M. <--------- para o yingyang
% en rach y e reach z
reach(Y) :- in(M,Y), #min{X:vtx(X)}=M.
reach(Z) :- reach(Y), in(Y,Z).

% Todos conectados
:- vtx(Y), not reach(Y).

distanciatotal(D) :- #sum{N: in (X,Y), edge (X,Y,N)}=D.
% #minimize{N,X,Y: in(X,Y), edge(X,Y,N)}. <----------- optimizacion (diapos)

#show in/2.
#show distanciatotal/1.