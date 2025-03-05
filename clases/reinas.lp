#const n=8.
row(1..n).
col(1..n).

% cada fila ren un xenerador distinto e por cada fila colles so unha
1 {queen(X,Y):col(Y)} 1 :- row(X).
:- queen(X,Y),queen(X',Y), X'<X.
:- queen(X,Y),queen(X',Y'), |X-X'|=|Y-Y'|, X!=X'.

% clingo --text reinas.lp | wc -l cantas reglas xenera
% en windows clingo --text reinas.lp | find /c ""