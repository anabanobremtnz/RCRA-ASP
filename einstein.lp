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
% :- at(color, yellow, H), at(person, brit, H'), H!=H'.
:- at (person, brit, H), not at(color, red, H).

% Sueco ten un can
:- at(pet, dog, H), not at(person, swede, H).
% :- at (pet, dog, H), not at(person, swede, H).
% ^Se pos can ten que estar sueco pero como no noso contexto é si solo si da igual

% Dane bebe té
:- at(drink, tea, H), not at(drink, tea, H).

% Casa verde á esquerda da blanca
% Non pode ser que a casa blanca non estea a dereita da verde
:- at(color, white, H), not at(color, green, H+1).

% O dono da casa verde bebe café
:- at(color, green, H), not at (drink, coffee, H).

% O dono que fuma Pall Mall ten un paxaro
:- at(tobacco, pall, H), not at(pet, bird, H).

% O dono da casa amarela fuma Dunhill
:- at(color, yellow, H), not at(tobacco, dunhill, H).

% O home que vive na terceira casa bebe leite
at (drink, milk, 3).

% O noruegués vive na primeira casa
at (person, norw, 1).

% O que fuma Blends vive ao lado do que ten gatos
:- at(tobacco, blends, H), not at(pet, cat, H+1), not at(pet, cat, H-1). 
% Habería casos nos que pode sair de rango este tipo de regla. Enton haberia facer comprobacions
% Neste caso esta negado -> non hai casa 0 nin 6 -> house(1..5)

% O home que ten cabalos vive ao lado do que fuma Dunhill
:- at(pet, horse, H), not at(tobacco, dunhill, H+1), not at(tobacco, dunhill, H-1).

% O propietario que fuma Bluem bebe cervexa
:- at(tobacco, bluem, H), not at(drink, beer, H).

% O alemán fuma Prince
:- at(person, german, H), not at(tobacco, prince, H).

% O noruego vive ao lado da casa azul
:- at(person, norw, H), not at(color, blue, H-1), not at(color, blue, H+1).

% O que fuma blends é veciño do que bebe auga
:- at(tobacco, blends, H), not at (drink, water, H-1), not at(drink, water, H+1).

% :- at(pet, cat, H), at (tobacco, blends, H'), |H-H'|!=1. -> Distancia pero non é funcional
%at (pet, cat, 1).

%#show paint/2.
#show at/3.
%#show solution/1.