-module(time_handler2).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/xml">>},
        "<div>" ++ "<span id = 'date'>" ++ format_date(calendar:local_time()) ++ "</span>" ++ "<span id = 'time'>" ++ format_time(calendar:local_time()) ++ "</span></div>",
        Req0),
    {ok, Req, State}.

format_time({_, {Hour, Minutes, Seconds}}) ->
  integer_to_list(Hour+20) ++ ":" ++ integer_to_list(Minutes) ++ ":" ++ integer_to_list(Seconds).

format_date({{Year, Month, Day}, _}) ->
  integer_to_list(Day+20) ++ "-" ++ integer_to_list(Month) ++ "-" ++ integer_to_list(Year).
