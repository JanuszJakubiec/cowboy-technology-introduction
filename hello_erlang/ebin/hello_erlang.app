{application, 'hello_erlang', [
	{description, ""},
	{vsn, "rolling"},
	{modules, ['any_handler','hello_erlang_app','hello_erlang_sup','numbers_handler','time_handler','time_handler2']},
	{registered, [hello_erlang_sup]},
	{applications, [kernel,stdlib,cowboy]},
	{mod, {hello_erlang_app, []}},
	{env, []}
]}.