:- module(hw5, [catomic_number/2, ion/2, molecule/2]) .
:- [catoms].

find_number([],0).
find_number([H|T],N) :- find_number(T,M), N is M+H.

catomic_number(X,Y) :- catom(X,_,_,T), find_number(T,Y).

find_last([H|T],R) :- T == [], R is H, !.
find_last([_|T],R) :- find_last(T,R).

first_catomic([H|_],R) :- catomic_number(H,R).

find_charge(V,C) :- V > 4, C is V-8, !.
find_charge(V,C) :- C is V.

ion(X,Y) :- catom(X,_,_,P), find_last(P,Q), find_charge(Q,Y).

sum_charge([],0) :- !.
sum_charge([H|T],R) :- sum_charge(T,Q), ion(H,P), R is P+Q.

catomic_sum([],0) :- !.
catomic_sum([H|T],R) :- catomic_number(H,P), catomic_sum(T,S), R is P+S.

find_catomics(0,_,[],_) :- !.
find_catomics(S,0,R,PA) :- catomic_number(R,S), S >= PA.
find_catomics(0,S,R,PA) :- catomic_number(R,S), S >= PA, !.
find_catomics(S,P,R,PA) :- S >= PA, P > 0, P >= S, catomic_number(RR,S), find_catomics(P,0,RS,S), (is_list(RS) -> (first_catomic(RS,SR), (S < SR ; S =:= SR), append([RR],RS,R)); ( first_catomic([RS],SR), (S < SR ; S =:= SR), append([RR],[RS],R))).
find_catomics(S,P,R,PA) :- Q is S-1, T is P+1, Q > 0, Q >= PA, find_catomics(Q,T,R,PA).

molecule([],0) :- !.
molecule([H|T],R) :- sum_charge([H|T],0), catomic_sum([H|T],R), !.
molecule(A,R) :- find_catomics(R,0,P,0), sum_charge(P,0), A = P.
