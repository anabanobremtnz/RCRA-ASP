switch(a;b;c).
time(0..3).                       % Situacions -> se son 3 toggles (situacion a-b-a)
{up(X, T): switch(X),time(T)}.    % Condicions que cumplen todos os elementos do conxunto "TAL QUE"
{light(T): time(T)}.
1 {t(X,T): switch(X)}1 :- time(T),T>0.     % Posibles accions -> cae no exame!! como facer todas as posibles xogadas etc...

% Cada condicion á dereita un xenerador distinto e dentro do conxunto xera todos

% Axiomas de efecto -> PREPOSICIONAL

:- up(X,T), t(X,T+1), up(X,T+1).            % Se fas toggle a ten que levantarse "up(a,T) /\ t(a) -> not up(a,T+1)"
:- not up(X,T), t(X,T+1), not up(X,T+1).    % Se a baixado e fas toggle a ten que levantarse "not up(a,T) /\ t(a) -> up(a,T+1)"

:- light(T), t(X,T+1), light(T+1).            % Non pode ser que se lle das ao interrumptor non cambie
:- not light(T), t(X,T+1), not light(T+1).    % Ou que se lle das cambie

:- up(Y,T), t(X,T+1), not up(Y,T+1), X!=Y.    % Frame axioms
:- not up(Y,T), t(X,T+1), up(Y,T+1), X!=Y.

up(a, 0). up(b, 0). up(c,0). light(0).    % Estados iniciais
t(a,1). t(b,2). t(a,3).                 % Secuencia de accions -> a-b-a

% Para ver so os predicados que interesan -> SHOW poñendo o num de argumentos!
#show up/2.
#show light/1.
#show t/2.