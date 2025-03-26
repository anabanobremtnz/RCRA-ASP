% ==================Definición do tamaño do taboleiro==================
gridsize(n).

% ==================Dominio==================
% As posicións son celdas sen cor (cell) ou con cor (fixed).
position(X,Y) :- cell(X,Y).
position(X,Y) :- fixed(X,Y,_).

% ==================Asignación de cores==================
% Se unha celda está fixa, asignamoslle a cor correspondente.
b(X,Y) :- fixed(X,Y,black).
w(X,Y) :- fixed(X,Y,white).

% Se non, eliximos entre branca e negra.
{b(X,Y); w(X,Y)} :- position(X,Y), not fixed(X,Y,_).

% ==================Restriccións=================
% Forzamos a que tome un e solo un cor e que non quede sin asignar
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
adj(X,Y,X+1,Y) :- position(X,Y), position(X+1,Y).
adj(X,Y,X-1,Y) :- position(X,Y), position(X-1,Y).
adj(X,Y,X,Y+1) :- position(X,Y), position(X,Y+1).
adj(X,Y,X,Y-1) :- position(X,Y), position(X,Y-1).

% Propagar conectividad dentro de cada clase (corrección del error)
connected_black(X,Y) :- b(X,Y).
connected_white(X,Y) :- w(X,Y).

% Un pixel está conectado a otro si hay adyacencia dentro de su color
connected_black(X2,Y2) :- connected_black(X1,Y1), adj(X1,Y1,X2,Y2), b(X2,Y2).
connected_white(X2,Y2) :- connected_white(X1,Y1), adj(X1,Y1,X2,Y2), w(X2,Y2).

% Contamos componentes conectadas
component_black(X,Y,ID) :- connected_black(X,Y), ID = #min{X1,Y1 : connected_black(X1,Y1)}.
component_white(X,Y,ID) :- connected_white(X,Y), ID = #min{X1,Y1 : connected_white(X1,Y1)}.

component_count(black, N) :- N = #count{ID : component_black(_,_,ID)}.
component_count(white, N) :- N = #count{ID : component_white(_,_,ID)}.

% Restricción: cada color debe ter só unha compoñente conectada
:- component_count(black, N), N > 1.
:- component_count(white, N), N > 1.

% ==================Saida==================
% Saida: _drawcircle(X,Y,C)
% En vez de números, saída de constantes simbólicas:
%   - _drawcircle(X,Y,black) para unha celda negra
%   - _drawcircle(X,Y,white) para unha celda branca
% (decode.py imprimirá 0 se C=black, e 1 se C=white.)

_drawcircle(X,Y,black) :- b(X,Y).
_drawcircle(X,Y,white) :- w(X,Y).

#show _drawcircle/3.
