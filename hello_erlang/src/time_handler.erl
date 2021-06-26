-module(time_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    Req1 = cowboy_req:set_resp_header(<<"Access-Control-Allow-Origin">>,<<"*">>, Req0),
    Req2 = cowboy_req:set_resp_header(<<"content-type">>, <<"text/xml">>, Req1),
    Req3 = cowboy_req:set_resp_body("<div>" ++ "<span id = 'date'>" ++ format_date(calendar:local_time()) ++ "</span>" ++ "<span id = 'time'>" ++ format_time(calendar:local_time()) ++ "</span></div>", Req2),
    Req = cowboy_req:reply(200, #{}, Req3),
    {ok, Req, State}.

format_time({_, {Hour, Minutes, Seconds}}) ->
  integer_to_list(Hour) ++ ":" ++ integer_to_list(Minutes) ++ ":" ++ integer_to_list(Seconds).

format_date({{Year, Month, Day}, _}) ->
  integer_to_list(Year) ++ "-" ++ integer_to_list(Month) ++ "-" ++ integer_to_list(Day).
