-module(numbers_handler).
-import(math,[cos/1,sin/1,sqrt/1,pow/2]).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req0=#{method := <<"GET">>}, State) ->
    Req1 = cowboy_req:set_resp_header(<<"content-type">>, <<"text/plain">>, Req0),
    Req2 = cowboy_req:set_resp_header(<<"Access-Control-Allow-Origin">>,<<"*">>, Req1),
    Req3 = cowboy_req:set_resp_body(onp(binary_to_list(cowboy_req:binding(numbers, Req0, <<"6 1 +">>))), Req2),
    Req = cowboy_req:reply(200, #{}, Req3),
    {ok, Req, State};
init(Req0=#{method := <<"POST">>}, State) ->
    {ok, String, _} = cowboy_req:read_body(Req0),
    Req1 = cowboy_req:set_resp_header(<<"content-type">>, <<"text/plain">>, Req0),
    Req2 = cowboy_req:set_resp_header(<<"Access-Control-Allow-Origin">>,<<"*">>, Req1),
    Req3 = cowboy_req:set_resp_body(onp(binary_to_list(String)), Req2),
    Req = cowboy_req:reply(200, #{}, Req3),
    {ok, Req, State}.

conv_integer(A) ->
  case string:to_integer(A) of
    {F, _Rest} -> F;
    true -> 0
  end.

convert(A) ->
  case string:to_float(A) of
    {error,no_float} -> conv_integer(A);
    {F,_Rest} -> F
  end.

onp_calculate([], [Head |_]) -> integer_to_list(Head);
onp_calculate(["cos"|Tail1],[Head1|Tail2]) ->
  onp_calculate(Tail1, [cos(Head1)|Tail2]);
onp_calculate(["sin"|Tail1],[Head1|Tail2]) ->
  onp_calculate(Tail1, [sin(Head1)|Tail2]);
onp_calculate(["sqrt"|Tail1],[Head1|Tail2]) ->
  onp_calculate(Tail1, [sqrt(Head1)|Tail2]);
onp_calculate([Head|Tail1],[]) ->
  onp_calculate(Tail1, [convert(Head)]);
onp_calculate([Head|Tail1],[Tail]) ->
  onp_calculate(Tail1, [convert(Head), Tail]);
onp_calculate([Head|Tail1],[Head1, Head2|Tail2]) ->
  case Head of
    "+" -> onp_calculate(Tail1, [Head2 + Head1 | Tail2]);
    "-" -> onp_calculate(Tail1, [Head2 - Head1 | Tail2]);
    "*" -> onp_calculate(Tail1, [Head2 * Head1 | Tail2]);
    "/" -> onp_calculate(Tail1, [Head2 / Head1 | Tail2]);
    "pow" -> onp_calculate(Tail1, [pow(Head2, Head1) | Tail2]);
    _ -> onp_calculate(Tail1, [convert(Head),Head1,Head2|Tail2])
  end.

onp(String) ->
  onp_calculate(string:tokens(String, " "), []).