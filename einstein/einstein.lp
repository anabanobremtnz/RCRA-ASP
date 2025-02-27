house(1..5).
% type(name_of_the_type,  value_of_the_type)
type( person, (brit;swede;dane;german;norw) ).
type(tobacco, (dunhill;pall;prince;bluem;blends)).
type(drink, (beer;water;tea;coffee;milk)).
type(color, (red;green;white;yellow;blue)).
type(pet, (fish;dog;cat;horse;bird)).
type(T) :- type(T,_).
at(color,blue,1).
at(pet,horse,1).
at(color,red,3).
at(drink,beer,3).

