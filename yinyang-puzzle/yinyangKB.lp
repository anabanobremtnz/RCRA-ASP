% ==================Definición do tamaño do taboleiro==================
gridsize(n).

% ==================Dominio==================
position(X,Y) :- cell(X,Y).
position(X,Y) :- fixed(X,Y,_).

% ==================Asignación de cores==================
b(X,Y) :- fixed(X,Y,black).
w(X,Y) :- fixed(X,Y,white).

% Se non, eliximos entre branca e negra, pero só unha vez
1 { b(X,Y); w(X,Y) } 1 :- position(X,Y), not fixed(X,Y,_).

% ==================Restriccións=================
% Cada celda debe ser negra o branca
:- position(X,Y), not b(X,Y), not w(X,Y).

% Non pode haber bloques 2x2 dunha soa cor:
:- b(X,Y), b(X+1,Y), b(X,Y+1), b(X+1,Y+1), X+1<=n, Y+1<=n.
:- w(X,Y), w(X+1,Y), w(X,Y+1), w(X+1,Y+1), X+1<=n, Y+1<=n.

% Non pode haber diagonais dunha soa cor:
:- b(X,Y), b(X+1,Y+1), w(X,Y+1), w(X+1,Y), X+1<=n, Y+1<=n.
:- w(X,Y), w(X+1,Y+1), b(X,Y+1), b(X+1,Y), X+1<=n, Y+1<=n.

% ==================Conectividad==================
% Adyacencia en 4 direcciones
adj(X,Y,X+1,Y) :- position(X,Y), position(X+1,Y), X+1<=n.
adj(X,Y,X-1,Y) :- position(X,Y), position(X-1,Y), X-1>=0. %NOTA: Si se reduce el tamaño de adjacencia a a X-1>=1, se puede obtener una solución más rápida en ciertos casos(algunos casos da insatisfacción)
adj(X,Y,X,Y+1) :- position(X,Y), position(X,Y+1), Y+1<=n.
adj(X,Y,X,Y-1) :- position(X,Y), position(X,Y-1), Y-1>=0. %NOTA: Si se reduce el tamaño de adjacencia a a Y-1>=1, se puede obtener una solución más rápida en ciertos casos(algunos casos da insatisfacción)

% ==================Conectividad Global==================
% Seleccionar un punto de inicio para cada color
min_white(X,Y) :- w(X,Y), not smaller_white(X,Y).
smaller_white(X,Y) :- w(X,Y), w(X1,Y1), X1 < X.
smaller_white(X,Y) :- w(X,Y), w(X1,Y1), X1 = X, Y1 < Y.

min_black(X,Y) :- b(X,Y), not smaller_black(X,Y).
smaller_black(X,Y) :- b(X,Y), b(X1,Y1), X1 < X.
smaller_black(X,Y) :- b(X,Y), b(X1,Y1), X1 = X, Y1 < Y.

start_w(X,Y) :- min_white(X,Y).
start_b(X,Y) :- min_black(X,Y).

% Ensure there is exactly one lexicographically smallest white cell if white cells exist
:- { start_w(X,Y) } != 1, { w(X,Y) } > 0.

% Ensure there is exactly one lexicographically smallest black cell if black cells exist
:- { start_b(X,Y) } != 1, { b(X,Y) } > 0.

% Inicializar celdas alcanzables
reached_w(X,Y) :- start_w(X,Y).
reached_b(X,Y) :- start_b(X,Y).

% Propagar alcanzabilidad
reached_w(X2,Y2) :- reached_w(X1,Y1), adj(X1,Y1,X2,Y2), w(X2,Y2).
reached_b(X2,Y2) :- reached_b(X1,Y1), adj(X1,Y1,X2,Y2), b(X2,Y2).

% Restricción: Todas las celdas del mismo color deben ser alcanzables
:- w(X,Y), not reached_w(X,Y).
:- b(X,Y), not reached_b(X,Y).

% ==================Saida==================
_drawcircle(X,Y,black) :- b(X,Y).
_drawcircle(X,Y,white) :- w(X,Y).

#show _drawcircle/3.