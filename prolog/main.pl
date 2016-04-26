:- use_module(library(http/http_open)).

getservedby(URL, X_Served_By) :-
        http_open(URL, In,
                  [ method(head),
                    header('x-served-by', X_Served_By)
                  ]),
        close(In).

scanservers(_, 0, Servers) :- sort(Servers, Servers1),
                    write(Servers1).

scanservers(URL, N, Servers) :- N > 0,
                    getservedby(URL, X_Served_By),
                    append([X_Served_By], Servers, Servers1),
                    write(N), write('-'), write(X_Served_By),nl,
                    N1 is N - 1,
                    scanservers(URL, N1, Servers1).

main :- Servers = [],
        getenv('TARGET_URL', Target_URL),
        scanservers(Target_URL, 100, []),
        nl,
        halt.
