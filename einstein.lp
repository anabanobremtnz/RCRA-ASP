house(1..5). % 5 casas

type(color,(red;green;white;yellow;blue)). % Red, Green, White, Yellow, Blue houses
type(person,(brit;swede;german;norw;dane)). % Brit, Swede, German, Norwegian,
type(pet,(dog;bird;cat;horse;fish)). % Dogs, Birds, Cats, Horses, Fish
type(drink,(beer;milk;water;coffee;tea)). % Beer, Milk, Water, Coffee, Tea
type(tobacco,(dunhill;prince;pall;bluem;blends)). % Pall Mall, Dunhill, Blends, Blue Master, Prince

%1{paint(C,H): color(C)} 1 :- house (H).
% Non repite a mesma cor para duas casas distintas - permutacion das cores: 5
%:- paint(C,H), paint(C,H'), H!=H'.

% Para cada c tes que escoller unha casa para pintala desa cor
%1{paint(C,H): house(H)} 1 :- color(C).
% Non podes pintar a mesma casa de duas cores
%:- paint(C,H), paint(C',H), C!=C'.

% Quen vive onde
%1 {lives(P,H): person(P)} 1 :- house(H).
%:- lives(P,H), lives(P,H'), H!=H'. % Mesma persoa en duas casas distintas non

% Todas seguen o mesmo patron -> convertimos os predicados en argumentos
% Mesmo predicado de tres argumentos

% Por cada casa e cada tipo teño que escoller un valor unico
1 {at(T,V,H): type(T,V)} 1 :- house(H), type(T,_). % Colle calquera tipo
:- at(T,V,H), at(T,V,H'), H!=H'. % Xeneralizamos a regra

% Brit vive en casa amarilla
:- at(color, yellow, H), at(person, brit, H'), H!=H'.

% Sueco ten un can
:- at(pet, dog, H), not at(person, swede, H).

%#show paint/2.
#show at/3.