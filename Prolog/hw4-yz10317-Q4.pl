% swipl hw4-yz10317-Q4.pl
% ['hw4-yz10317-Q4.pl'].


% Question 4.1
time(tokyo, 5).
time(rio, 10).
time(berlin, 20).
time(denver, 25).


% Question 4.2
team([tokyo, rio, berlin, denver]).


% Question 4.3
max(A, B, B) :- A < B, !.
max(A, _, A).

cost(L, C) :-
    cost(L, C, 0).
cost([X|Xs], C, Acc) :-
    time(X, Time),
    max(Acc, Time, New_Acc),
    cost(Xs, C, New_Acc).
cost([], C, C).


% Question 4.4
split(L, [X, Y], M) :-
    member(X, L),
    member(Y, L),
    compare(<, X, Y),
    subtract(L, [X, Y], M).

move(st(l, L1), st(r, L2), r(M), C) :-
    split(L1, M, L2),
    cost(M, C).

move(st(r, L1), st(l, L2), l(M), C) :-
    time(M, C),
    not(member(M, L1)),
    L2 = [M|L1].


% Question 4.5
cross(M, D) :-
    team(T),
    trans(st(l, T), st(r, []), M, DO),
    DO=<D.

trans(st(r, []), st(r, []), [], 0).
trans(I, F, [X|Xs], C) :-
    move(I, New, X, C1),
    trans(New, F, Xs, C2),
    C is C1 + C2.

solution(M) :- cross(M, 60).