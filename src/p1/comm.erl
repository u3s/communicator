-module(comm).

-export([start_client/1,
         stop_client/1,
         send_message/3,
         receive_next_message/1]).

%% CLIENT INTERFACE
start_client(Username) when is_atom(Username) ->
    case whereis(Username) of
        undefined ->
            ClientPid = spawn_link(fun client_loop_init/0),
            register(Username, ClientPid),
            ClientPid ! {set_name, Username},
            ok;
        _Pid ->
            io:format("Client with name '~p' already exists.~n", [Username])
    end;
start_client(_Username) ->
    io:format("Username shall be an atom, client not started.~n").

stop_client(Username) when is_atom(Username) ->
    case whereis(Username) of
        undefined ->
            io:format("Client with name '~p' does not exists, nothing to stop.~n", [Username]);
        Pid ->
            Pid ! stop
    end;
stop_client(_Username) ->
    io:format("Username shall be an atom, nothing to stop.~n").

send_message(UsernameFrom, UsernameTo, Msg) ->
    case whereis(UsernameFrom) of
        undefined ->
            io:format("Client with name '~p' does not exists, nothing to send.~n", [UsernameFrom]);
        Pid ->
            Pid ! {send_message, UsernameTo, Msg},
            ok
    end.

receive_next_message(Username) ->
    case whereis(Username) of
        undefined ->
            io:format("Client with name '~p' does not exists, nothing to receive.~n", [Username]);
        Pid ->
            Pid ! read_next_message,
            ok
    end.

%% CLIENT INTERNAL FUNCTIONS
client_loop_init() ->
    io:format("~p Client loop started.~n", [self()]),
    client_loop(#{name=>undefined, inbox=>[]}).

client_loop(#{name:=Name, inbox:=Inbox}=State) ->
    receive
        stop ->
            io:format("~p Client loop stopped.~n", [self()]);
        {set_name, NewName} ->
            client_loop(State#{name=>NewName});
        {send_message, UsernameTo, Msg} ->
            case whereis(UsernameTo) of
                undefined ->
                    io:format("~p Recipient '~p' does not exist, nothing to send.~n", [self(), UsernameTo]);
                Pid ->
                    Pid ! {message, Name, Msg}
            end,
            client_loop(State);
        {message, From, Msg} ->
            client_loop(State#{inbox=>Inbox ++ [{From, Msg}]});
        read_next_message ->
            case Inbox of
                [] ->
                    io:format("~p No new messages.~n", [self()]),
                    client_loop(State);
                [{From, Msg}|T] ->
                    io:format("~p ~p: ~p~n", [self(), From, Msg]),
                    io:format("~p ~p messages left.~n", [self(), length(T)]),
                    client_loop(State#{inbox=>T})
            end;
        Msg -> 
            io:format("~p Client received unknown message: ~p~n", [self(), Msg]),
            client_loop(State)
    end.
