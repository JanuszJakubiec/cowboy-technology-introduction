-module(hello_erlang_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {"test1.prez", [
            {"/", cowboy_static, {priv_file, hello_erlang, "static/index.html"}},
            {"/getTime", time_handler, []}, 
            {"/sum_numbers/[:numbers]", numbers_handler, []}
        ]},
        {"test2.prez", [
            {"/getTime", time_handler2, []},
            {"/[:sitename]", any_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    hello_erlang_sup:start_link().

stop(_State) ->
	ok.
