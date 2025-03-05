digit(1..9).
row(0..8).
col(0..8).
cell(2,0,6). cell(5,0,2).
cell(5,1,5).
cell(0,2,7). cell(4,2,9).
cell(1,3,3). cell(2,3,1). cell(4,3,8). cell(7,3,7).
cell(0,4,6). cell(8,4,8).
cell(1,5,2). cell(5,5,3). cell(7,5,4). cell(8,5,5).
cell(5,6,9). cell(6,6,3).
cell(1,7,7). cell(2,7,4). cell(4,7,6). cell(7,7,2).
cell(0,8,9). cell(4,8,7).

% Non repite filas e columnas
1 {cell(X,Y,N):digit(N)} 1 :- row(X),col(Y).
:- cell(X,Y,N), cell(X',Y,N), X<X'.
:- cell(X,Y,N), cell(X,Y',N), Y<Y'.

% Non repite cadrantes - collendo a fila e a columna da celda e dividindo por 3
:- cell(X,Y,N), cell(X',Y',N), X/3=X'/3, Y/3=Y'/3, X!=X', Y!=Y'.
