:- initialization(main).

main :-
    area([[3,2],[6,2],[7,6],[4,6],[5,5],[5,3],[3,2]],Area),
    Area =:= 7.5,
    write('[] = "PASS".'),
    nl.

area([_],0).
area([[A,B],[C,D]|E],F) :-
    area([[C,D]|E],G),
    F is (A*D-B*C)/2+G.
