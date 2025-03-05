income(jan, 5).
income(feb, 3).
income (mar, -2).
income (apr, 10).
%total(S) :- #sum{X: income(M,X)} = S.
total(S) :- #sum{X,M: income(M,X)} = S.
{(5,jan),(3,feb),(-2,mar),(10,apr),(10,may),(5,jun),(10,jul)}.
income (may, 10).
income (jun, 5).
income (jul, 10).
% Os valores se repiten, non os conta!
% Para evitalo -> tupla de valores sen parentesis -> aplicase á primeira coordenada da tupla