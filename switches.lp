{a0;b0;c0;light0}.  % Fluentes en estado inicial
{a1;b1;c1;light1}.  % Fluentes en estado resultante
1{ta;tb;tc}1.       % Posibles accions

% Axiomas de efecto
% a0 /\ ta -> not a1
:- a0, ta, a1.          % Se fas toggle a ten que levantarse
% not a0 /\ ta -> a1
:- not a0, ta, not a1.   % Se a baixado e fas toggle a ten que levantarse

:- b0, tb, b1.
:- not b0, tb, not b1.
:- c0, tc, c1.
:- not c0, tc, not c1.

% Non pode ser que se lle das ao interrumptor siga apagada ou acesa, que non cambie
:- light0, ta, light1.
:- not light0, ta, not light1.

:- light0, tb, light1.
:- not light0, tb, not light1.
:- light0, tc, light1.
:- not light0, tc, not light1.

% Frame axioms
:- b0, ta, not b1.
:- not b0, ta, b1.
:- c0, ta, not c1.
:- not c0, ta, c1.

:- a0, tb, not a1.
:- not a0, tb, a1.
:- c0, tb, not c1.
:- not c0, tb, c1.

:- b0, tc, not b1.
:- not b0, tc, b1.
:- a0, tc, not c1.
:- not c0, tc, c1.

% Definir estados iniciais
a0.
b0.
c0.
light0.
% ta.