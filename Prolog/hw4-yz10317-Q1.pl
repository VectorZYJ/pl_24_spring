male(jason).
male(walt).
male(kevin).
male(joe).
male(tom).
male(burt).
male(ned).
male(bob).
male(troy).
male(fred).
male(walt).
% test case for question 7
male(a).

parent(jason, walt).
parent(walt, isabella).
parent(jane, kevin).
parent(bob, joe).
parent(joe, isabella).
parent(mary, jen).
parent(wendy, jason).
parent(sade, joe).
parent(pebbles, walt).
parent(steph, isabella).
parent(kendra, bob).
parent(tina, sade).
parent(fred, pebbles).
parent(burt, sade).
parent(troy, jason).
parent(troy, brandon).
parent(wendy, brandon).
parent(bob, joe).
parent(ned, bob).
parent(tom, kevin).
% test case for question 7
parent(a, c).
parent(a, d).
parent(a, e).
parent(b, c).
parent(b, d).
parent(b, e).
parent(c, f).

grandfather(X, Y) :- male(X), parent(X, Z), parent(Z, Y).


% swipl hw4-yz10317-Q1.pl
% ['hw4-yz10317-Q1.pl'].

% Question 1.1
parents(X, Y) :- X \= Y, parent(X, Z), parent(Y, Z), !.

% Question 1.2
sibling(X, Y) :- X \= Y, parent(P, X), parent(Q, X), P \= Q, parent(P, Y), parent(Q, Y), !.

% Question 1.3
half_sibling(X, Y) :- X \= Y, not(sibling(X, Y)), parent(Z, X), parent(Z, Y), !.

% Question 1.4
uncle(X, Y) :- parent(Z, Y), male(Z), sibling(X, Z), !. 

% Question 1.5
ancestor(X, Y) :- parent(X, Y) ; parent(X, Z), Z \= Y, ancestor(Z, Y), !.

% Question 1.6
related(X, Y) :- X \= Y, ancestor(Z, X), ancestor(Z, Y), !.

% Question 1.7
grandfather_modified(X, Y) :- male(X), parent(X, Z), parent(Z, Y), !.
% For this question, we could add a cut operator at the end of several rules.
% In this case, when all conditions both satisfy, backtracking for other options are skipped, reducing execution time.
% Using test case for question 7 above, we can get the following tracing records:

% [trace]  ?- grandfather(a, f).
%    Call: (12) grandfather(a, f) ? creep
%    Call: (13) male(a) ? creep
%    Exit: (13) male(a) ? creep
%    Call: (13) parent(a, _205444) ? creep
%    Exit: (13) parent(a, c) ? creep
%    Call: (13) parent(c, f) ? creep
%    Exit: (13) parent(c, f) ? creep
%    Exit: (12) grandfather(a, f) ? creep
% true ;
%    Redo: (13) parent(a, _205444) ? creep
%    Exit: (13) parent(a, d) ? creep
%    Call: (13) parent(d, f) ? creep
%    Fail: (13) parent(d, f) ? creep
%    Redo: (13) parent(a, _205444) ? creep
%    Exit: (13) parent(a, e) ? creep
%    Call: (13) parent(e, f) ? creep
%    Fail: (13) parent(e, f) ? creep
%    Fail: (12) grandfather(a, f) ? creep
% false.

% [trace]  ?- grandfather_modified(a, f).
%    Call: (12) grandfather_modified(a, f) ? creep
%    Call: (13) male(a) ? creep
%    Exit: (13) male(a) ? creep
%    Call: (13) parent(a, _222616) ? creep
%    Exit: (13) parent(a, c) ? creep
%    Call: (13) parent(c, f) ? creep
%    Exit: (13) parent(c, f) ? creep
%    Exit: (12) grandfather_modified(a, f) ? creep
% true.