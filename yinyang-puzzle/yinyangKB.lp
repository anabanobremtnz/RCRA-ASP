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
% Peche transitivo - Veciños: orthogonal (up, down, left, right) polo grid
neighbor(X,Y,X-1,Y) :- position(X,Y), X>=1.
neighbor(X,Y,X+1,Y) :- position(X,Y), X<n.
neighbor(X,Y,X,Y-1) :- position(X,Y), Y>=1.
neighbor(X,Y,X,Y+1) :- position(X,Y), Y<n.

% Para as negras:
% Raiz fixa para as casillas negras.
% A raiz escollida e a celda negra fixa coas menores coordenadas.
root_black(X,Y) :- fixed(X,Y,black), not smaller_black(X,Y).
smaller_black(X,Y) :- fixed(X,Y,black), fixed(X1,Y1,black), X1 < X.
smaller_black(X,Y) :- fixed(X,Y,black), fixed(X1,Y1,black), X1 = X, Y1 < Y.

% Se unha celda negra é alcanzable desde a raiz, entón todas as súas veciñas tamén son negras.
reach_black(X,Y) :- root_black(X,Y).
reach_black(X2,Y2) :- reach_black(X,Y), neighbor(X,Y,X2,Y2), b(X2,Y2).
:- b(X,Y), not reach_black(X,Y).

% Para as brancas:
% Designamos unha raiz entre as celdas brancas fixas (a menor en orde lexicográfica).
root_white(X,Y) :- fixed(X,Y,white), not smaller_white(X,Y).
smaller_white(X,Y) :- fixed(X,Y,white), fixed(X1,Y1,white), X1 < X.
smaller_white(X,Y) :- fixed(X,Y,white), fixed(X1,Y1,white), X1 = X, Y1 < Y.

% Se unha celda branca é alcanzable desde a raiz, entón todas as súas veciñas tamén son brancas.
reach_white(X,Y) :- root_white(X,Y).
reach_white(X2,Y2) :- reach_white(X,Y), neighbor(X,Y,X2,Y2), w(X2,Y2).
:- w(X,Y), not reach_white(X,Y).

% Non pode haber bloques 2x2 dunha soa cor:
:- fixed(X,Y,black), fixed(X+1,Y,black), fixed(X,Y+1,black), fixed(X+1,Y+1,black), X+1<=n, Y+1<=n.
:- fixed(X,Y,white), fixed(X+1,Y,white), fixed(X,Y+1,white), fixed(X+1,Y+1,white), X+1<=n, Y+1<=n.

% Non pode haber diagonais dunha soa cor:
:- fixed(X,Y,black), fixed(X+1,Y+1,black), fixed(X,Y+1,white), fixed(X+1,Y,white), X+1<=n, Y+1<=n.
:- fixed(X,Y,white), fixed(X+1,Y+1,white), fixed(X,Y+1,black), fixed(X+1,Y,black), X+1<=n, Y+1<=n.

% ==================Saida==================
% Saida: _drawcircle(X,Y,C)
% En vez de números, saída de constantes simbólicas:
%   - _drawcircle(X,Y,black) para unha celda negra
%   - _drawcircle(X,Y,white) para unha celda branca
% (decode.py imprimirá 0 se C=black, e 1 se C=white.)

_drawcircle(X,Y,black) :- b(X,Y).
_drawcircle(X,Y,white) :- w(X,Y).

#show _drawcircle/3.