-module(db).
-compile(export_all).

% Exercise 3-4 pg 83

new() -> [].

destroy(_) -> ok.

write(Key,Element,Db) ->
	OldKey = read(Key,Db),
	if
		OldKey == false -> [{Key,Element}|Db];
		OldKey /= false -> Db %io:format("Key already exists")
	end.
	
	
read(_,[]) -> false;
read(Key,[{H,V}|_]) when H == Key -> V;
read(Key,[{H,_}|T]) when H /= Key ->
	read(Key,T).
	
match(_,[]) -> false;
match(Val,[{H,V}|_]) when V == Val -> H;
match(Val,[{_,V}|T]) when V /= Val ->
	match(Val,T).

delete(Key,Db) -> delete(Key,Db,[]).
delete(_,[],Acc) -> Acc;
delete(Key,[{H,V}|T],Acc) when Key /= H ->
	delete(Key,T,[{H,V}|Acc]);
delete(Key,[{H,_}|T],Acc) when Key == H ->
	delete(Key,T,Acc).
