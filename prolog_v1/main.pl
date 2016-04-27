:- use_module(library(http/http_open)).

% Make an http request and retrieve the X-Served-By header.
getservedby(URL, X_Served_By) :-
                    http_open(URL, In,
                        [
                            method(head),
                            header('x-served-by', X_Served_By)
                        ]),
                    close(In).

% Output each item of a list separated by newline characters.
% - If an empty list then do nothing and stop recursing.
writelist([]).

% - Write the head of the list followed by a newline then call recursively on the tail.
writelist([H|T]) :-
                    write(H),
                    nl,
                    writelist(T).

% Call the method to make the http request N times.
% - If the iteration count is zero, then sort the list to remove duplicates, write the list, and stop recursing.
scanservers(_, 0, Servers) :-
                    sort(Servers, Servers1),
                    nl,
                    writelist(Servers1).

% - Call to get the X-Served-By header, add it to a list, decrement N and call recursively.
scanservers(URL, N, Servers) :-
                    getservedby(URL, X_Served_By),
                    append([X_Served_By], Servers, Servers1),
                    N1 is N - 1,
                    scanservers(URL, N1, Servers1).

% Main entry point. Get the environment variables to determine the target URL and number of times to call.
% Write out the parameters for reference, scan for servers and then write the list of servers.
main :- getenv('TARGET_URL', Target_URL),
        getenv('ITERATIONS', Iterations_env),
        atom_number(Iterations_env, Iterations),
        write('Target Url: '),
        write(Target_URL),nl,
        write('Iterations: '),
        write(Iterations),nl,
        nl,
        write('Servers found:'),
        scanservers(Target_URL, Iterations, []),
        nl,
        halt.
