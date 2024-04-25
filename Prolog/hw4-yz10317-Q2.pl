% swipl hw4-yz10317-Q2.pl
% ['hw4-yz10317-Q2.pl'].


% Question 2.1
member_positions(X, L, Ps) :- 
    member_positions(X, L, Ps, 1, []).
member_positions(X, [Y|Ys], Ps, Num, Acc) :- 
    X = Y, !, 
    append(Acc, [Num], New_Acc), 
    Next is Num + 1,
    member_positions(X, Ys, Ps, Next, New_Acc).
member_positions(X, [_|Ys], Ps, Num, Acc) :- 
    Next is Num + 1,
    member_positions(X, Ys, Ps, Next, Acc), !.
member_positions(_, [], Ps, _, Ps).
% ?- member_positions(2, [1, 2, 3, 2, 1], Ps).


% Question 2.2
is_subset([X|Xs], L) :-
    member(X, L), !,
    is_subset(Xs, L).
is_subset([], _).
% ?- is_subset([a, c], [a, b, c, d]).
% ?- is_subset([a, c, d], [a, b]).


% Question 2.3
difference(L1, L2, Diff) :-
    difference(L1, L2, Diff, []).
difference([X|Xs], L2, Diff, Acc) :-
    member(X, L2), !, 
    difference(Xs, L2, Diff, Acc).
difference([X|Xs], L2, Diff, Acc) :-
    append(Acc, [X], New_Acc),
    difference(Xs, L2, Diff, New_Acc).
difference([], _, Diff, Diff).
% difference([1, 2, 3, 4], [2, 4, 5], Diff).


% Question 2.4
encode([], []).
encode([X|Xs], L2) :-
    encode(Xs, L2, [], 1, X).
encode([X|Xs], L2, Acc, Num, Elem) :-
    X = Elem, !,
    New_Num is Num + 1,
    encode(Xs, L2, Acc, New_Num, Elem).
encode([X|Xs], L2, Acc, Num, Elem) :-
    Encoded = [Num, Elem],
    append(Acc, [Encoded], New_Acc),
    encode(Xs, L2, New_Acc, 1, X).
encode([], L2, Acc, Num, Elem) :-
    Encoded = [Num, Elem],
    append(Acc, [Encoded], New_Acc),
    L2 = New_Acc.
% encode([a, a, a, a, b, c, c, a, a, d, e, e, e, e], X).


% Question 2.5
encode_term(Num, Elem, [Num, Elem]) :-
    Num > 1, !.
encode_term(1, Elem, Elem).

encode_modified([], []).
encode_modified([X|Xs], L2) :-
    encode_modified(Xs, L2, [], 1, X).
encode_modified([X|Xs], L2, Acc, Num, Elem) :-
    X = Elem, !,
    New_Num is Num + 1,
    encode_modified(Xs, L2, Acc, New_Num, Elem).
encode_modified([X|Xs], L2, Acc, Num, Elem) :-
    encode_term(Num, Elem, Encoded),
    append(Acc, [Encoded], New_Acc),
    encode_modified(Xs, L2, New_Acc, 1, X).
encode_modified([], L2, Acc, Num, Elem) :-
    encode_term(Num, Elem, Encoded),
    append(Acc, [Encoded], New_Acc),
    L2 = New_Acc.
% encode_modified([a, a, a, a, b, c, c, a, a, d, e, e, e, e], X).


% Question 2.6
my_length(L, N) :-
    my_length(L, N, 0).
my_length([_|Xs], N, Acc) :-
    New_Acc is Acc + 1,
    my_length(Xs, N, New_Acc).
my_length([], N, N).

rotate(L1, N, L2) :-
    N < 0, !,
    my_length(L1, M),
    New_N is M + N,
    rotate(L1, New_N, L2, []).
rotate(L1, N, L2) :-
    rotate(L1, N, L2, []).
rotate([X|Xs], N, L2, Acc) :-
    N > 0, !,
    append(Acc, [X], New_Acc),
    New_N is N - 1,
    rotate(Xs, New_N, L2, New_Acc).
rotate(L1, 0, L2, Acc) :-
    append(L1, Acc, New_Acc),
    L2 = New_Acc.
% ?- rotate([a, b, c, d, e, f, g, h], 3, X).
% ?- rotate([a, b, c, d, e, f, g, h], -2, X).