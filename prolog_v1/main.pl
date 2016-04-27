:- use_module(library(http/http_open)).

getservedby(URL, X_Served_By) :-
        http_open(URL, In,
                  [ method(head),
                    header('x-served-by', X_Served_By)
                  ]),
        close(In).

scanservers(_, 0, Servers) :- sort(Servers, Servers1),
                    nl,
                    write(Servers1).

scanservers(URL, N, Servers) :- N > 0,
                    getservedby(URL, X_Served_By),
                    append([X_Served_By], Servers, Servers1),
                    % write(N), write('-'), write(X_Served_By),nl,
                    write('.'),
                    N1 is N - 1,
                    scanservers(URL, N1, Servers1).

main :- getenv('TARGET_URL', Target_URL),
        getenv('ITERATIONS', Iterations_env),
        atom_number(Iterations_env, Iterations),
        write('Target Url: '),
        write(Target_URL),nl,
        write('Iterations: '),
        write(Iterations),nl,
        scanservers(Target_URL, Iterations, []),
        nl,
        halt.
