
build_kb:-
	write('Welcome to Pro-Wordle!'),nl,
	write('----------------------'),nl,nl,
	add,
	write('Done building the words database...'),nl.
	
		
add:-
	write('Please enter a word and its category on separate lines:'),
	nl,
	read(W), (nonvar(W),
	((W = done,nl) ;
		(read(C),
		assert(word(W,C)),
		add)
		) ;
		(write("Don't enter a variable! Try Again. ") , nl,nl,
		add)).

is_category(C):-
	word(_,C).

categories(L):-
	setof(C,is_category(C),L).
	
available_length(L):-
	word(W,_),
	string_length(W,L).

pick_word(W,L,C):-
	word(W,C),
	string_length(W,L).

remove_duplicates([],[]).

remove_duplicates([H|T],[H|T1]):-
	\+member(H,T),
	remove_duplicates(T,T1).
	
remove_duplicates([H|T],L):-
	member(H,T),
	remove_duplicates(T,L).

correct_letters(L1,L2,CL):-
	intersection(L2,L1,CL1),
	remove_duplicates(CL1,CL).


correct_positions([],[],[]).

correct_positions([H|T1],[H|T2],[H|T3]):-
	correct_positions(T1,T2,T3).

correct_positions([H1|T1],[H2|T2],PL):-
	H1\=H2,
	correct_positions(T1,T2,PL).

choose_category(C):-
	write('Choose a category: '), nl,
	read(M),
	((\+is_category(M),
	write('This category does not exist.'), nl,
	choose_category(C));
	
	is_category(M),
	C = M).

read_number(N):-
	read(X),
	
	((\+number(X),
	write('This is not a valid number! Try again'),nl,
	read_number(N));
	
	(number(X),
		N=X)).
	

choose_length(L,C,G):-
	write('Choose a length: '), nl,
	read_number(X),
	((word_length(X,C),
	write('Game started. You have '),
	G is X+1,
	L = X,
	write(G),
	write(' guesses.'), nl, nl);
	
	
	(\+word_length(X,C),
	write('There are no words of this length.'), nl,
	choose_length(L,C,G))).


word_checker(K):-
		word(X,_),
		K = X.
	

kb_len_read(L,G,K):-
	read_guess(L,G,X),
	
	(
	(word_checker(X),
	K = X)
	;
	(\+word_checker(X),
	write('This word does not exist in knowledge base. Try again.'),nl,
	write('Remaining Guesses are '), write(G), nl, nl,
	write("Enter a word composed of "), write(L) , write(" letters:") , nl,
	kb_len_read(L,G,K))
	).
	
	


read_guess(L,G,K):-
	read(X),
	((
	\+string_length(X,L),
	write('Word is not composed of '), 
	write(L),
	write(' letters. Try again.'), nl,
	write('Remaining Guesses are '),
	write(G), nl,nl,
	write("Enter a word composed of "), write(L) , write(" letters:") , nl,
	read_guess(L,G,K));
	(
	string_length(X,L),
	K = X)).
	

guess(L,G,R):-
	write('Enter a word composed of '),
	write(L),
	write(' letters:'),nl,
	
	%read_guess(L,G,K),
	kb_len_read(L,G,K),
	
	string_chars(K,KL),
	string_chars(R,RL),
	
	
	correct_letters(KL,RL,CL),
	correct_positions(KL,RL,CP),
	G1 is G-1,
	
	(win(L,CP);
	
	(G1=0,
	\+win(L,CP),
	write('You lost!');

	
	(
	write('Correct letters are: '),
	write(CL),nl,
	

	write('Correct letters in correct positions are: '),
	write(CP),nl,
	
	
	write('Remaining Guesses are '),
	write(G1),nl,nl,
	
	guess(L,G1,R)))).
	
	
	
	
	
win(L,CP):-
	length(CP,L),
	write('You Won!'), nl.


word_length(L,C):-
	word(W,C),
	string_length(W,L).
	
	
	
play:-
	write('The available categories are: '),
	categories(Ctg),
	write(Ctg), nl,
	
	choose_category(C),
	choose_length(L,C,G),
	
	setof(W,pick_word(W,L,C),WordList),
	random_member(R,WordList),
	
	guess(L,G,R).

main:-

	build_kb,
	nl,
	play.

	



	
	
	
	
	
	
	


