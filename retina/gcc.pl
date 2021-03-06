% Gray Code Counter
% Code from the book "Clause and Effect" Chapter 8

:- initialization(main).

main :-
    testgcc([1,1,1,1,1,1,1,1,1],s(0,0,0),Q),
    Q = [s(0,0,1),s(0,1,1),s(0,1,0),s(1,1,0),s(1,1,1),s(1,0,1),s(1,0,0),s(0,0,0),s(0,0,1)],
    write('[] = "PASS".'),
    nl.

and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).

or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).

inv(0,1).
inv(1,0).

dff(_,0,Q,Q).
dff(D,1,_,D).

neta(A,B,Q) :-
    and(A,B,T1),
    inv(A,NA),
    inv(B,NB),
    and(NA,NB,T2),
    or(T1,T2,Q).

netb(A,B,C,Q1,Q2) :-
    and(A,C,T1),
    inv(C,NC),
    and(B,NC,T2),
    inv(A,NA),
    and(NA,C,T3),
    or(T1,T2,Q1),
    or(T2,T3,Q2).

gcc(C,s(Qa,Qb,Qc),s(Za,Zb,Zc)) :-
    netb(Qa,Qb,Qc,D1,D2),
    neta(Qa,Qb,D3),
    dff(D1,C,Qa,Za),
    dff(D2,C,Qb,Zb),
    dff(D3,C,Qc,Zc).

testgcc([],_,[]).
testgcc([C|Cs],S,[N|Ns]) :-
    gcc(C,S,N),
    testgcc(Cs,N,Ns).
