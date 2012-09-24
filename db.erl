-module(db).
-compile(export_all).

% Exercise 3-4 pg 83

new() -> [].

destroy(_) -> ok.

write(Key,Element,Db) ->
	{_,OldKey} = read(Key,Db),
	if
		OldKey == not_found -> [{Key,Element}|Db];
		OldKey /= not_found -> Db %io:format("Key already exists")
	end.
	
	
read(_,[]) -> {error, not_found};
read(Key,[{H,V}|_]) when H == Key -> {ok,V};
read(Key,[{H,_}|T]) when H /= Key ->
	read(Key,T).

match(Val,Db) -> match(Val,Db,[]).
match(_,[],Acc) -> Acc;
match(Val,[{H,V}|T],Acc) when V == Val ->
	match(Val,T,[H|Acc]);
match(Val,[{_,V}|T],Acc) when V /= Val ->
	match(Val,T,Acc).

delete(Key,Db) -> delete(Key,Db,[]).
delete(_,[],Acc) -> Acc;
delete(Key,[{H,V}|T],Acc) when Key /= H ->
	delete(Key,T,[{H,V}|Acc]);
delete(Key,[{H,_}|T],Acc) when Key == H ->
	delete(Key,T,Acc).
