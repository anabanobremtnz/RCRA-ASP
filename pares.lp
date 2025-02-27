par(2,3).
par(3,2).
par(4,5).
par(9,9).
par(6,1).
minpar(P) :- #min{(X,Y): par(X,Y)} = P. % ou max