person(a;b;c;d;e).
hates(a,c).
hates(d,e).
likes(a,d).
likes(c,e).
1{sit(X,T: table(T,_))}1 :- person(X).
:- table (T,N), #count{X:sit(X,T)}>N.
