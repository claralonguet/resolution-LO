% Predicat pour vérifier si une clause est résolue
resolve_clause([], _, _) :- fail.
resolve_clause([L|Lits], Clause, Resolvent) :-
    member(-L, Clause),
    select(-L, Clause, Rest),
    select(L, Lits, NewLits),
    append(NewLits, Rest, Resolvent).

% Predicat pour appliquer la résolution entre deux clauses
resolve_step(Clause1, Clause2, Resolvent) :-
    resolve_clause(Clause1, Clause2, Resolvent);
    resolve_clause(Clause2, Clause1, Resolvent).

% Predicat pour appliquer la résolution sur toutes les clauses
resolve_clauses([], _) :- fail.
resolve_clauses([Clause|Clauses], Resolvent) :-
    member(OtherClause, Clauses),
    resolve_step(Clause, OtherClause, Resolvent);
    resolve_clauses(Clauses, Resolvent).

% Predicat principal pour résoudre la formule CNF
resolve(Clauses) :-
    resolve_clauses(Clauses, Resolvent),
    (Resolvent = [] -> 
        writeln('Unsatisfiable: empty clause found'), fail;
        resolve([Resolvent|Clauses])
    );
    writeln('Satisfiable: empty clause not found').
