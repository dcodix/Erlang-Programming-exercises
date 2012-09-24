-module(list).
-compile(export_all).
 
% Exercise 3-5 pg 83

filter(List,N) -> filter(List,N,[]).
filter([],_,Acc) -> Acc;
filter([H|T],N,Acc) when H =< N ->
	filter(T,N,[H|Acc]);
filter([H|T],N,Acc) when H > N ->
	filter(T,N,Acc).

reverse([]) -> [];
reverse([H|T]) ->
	reverse(T) ++ [H].
	
concatenate([]) -> [];
concatenate([H|T]) ->
	if
		not is_list(H) -> [H] ++ concatenate(T);
		is_list(H) -> concatenate(H) ++ concatenate(T)
	end.

%flatten would be the same as concatenate
