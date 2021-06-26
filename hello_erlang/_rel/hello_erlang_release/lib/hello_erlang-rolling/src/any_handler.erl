-module(any_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        "Hello " ++ cowboy_req:binding(sitename, Req0, "Janusz"),
        Req0),
    {ok, Req, State}.