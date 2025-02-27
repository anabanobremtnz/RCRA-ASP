{c1;c2;d1;d2}.

% d1: hai dama no cuarto 1 ------------------

% c1: d1 /\ not d2
:- c1, not d1.
:- c1, d2.

% d1 /\ not d2 -> c1
:- d1, not d2, not c1.

% c2 <-> d1 xor d2 ---------------------------

% d1 xor d2 -> c2
:- d1, not d2, not c2.
:- not d1, d2, not c2.

% c2 -> d1 xor d2
:- c2, d1, d2.
:- c2, not d1, not d2.

% Un cartel minte, outro di a verdade (XOR) --
:- c1, c2.
:- not c1, not c2.