% TEMA 2 - DIAPO 11
{w;h;r;tv}.

% Premisa 1: on weekends, I don't watch TV
:- w, tv.

% Premisa 2: I'm happy when it rains, except in the weekends
:- not w, not h.

% Premisa 3: I'm watching TV but I'm not happy --> but/pero é conxuncion! --> AND
tv.
:- h.

% Comprobar a conclusion "not r"
:- not r.