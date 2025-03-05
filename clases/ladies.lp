{c1;c2;c3}1.
2{t1;t2;t3}2.

% c1 <-> t1
:- c1, not t1.
:- not c1, t1.

% c2 <-> not t2
:- c2, t2.
:- not c2, not t2.

% c3 <-> t2
:- c3, not t2.
:- not c3, t2.