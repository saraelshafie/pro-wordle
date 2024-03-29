## Description
A spin on New York Times's "Wordle", where a player starts off by entering words and their related categories in order to create the game's database. Then, the player can pick a category and start guessing the word using a limited number of guesses.

## Code Details
- build_kb:- starts by building the knowledge base.
It starts by writing a welcome message ‘Welcome to Pro-Wordle!’ and starts a new line with
appropriate spacing. It then calls the predicate add to assert data into the knowledge base.
After all data is entered, it writes ‘Done building the words database...’, to indicate the end of
the building phase.

- add:- adds a word with its category into the knowledge base.
It starts by writing ‘Please enter a word and its category on separate lines: ‘ and starting a new
line. It then reads what the user entered and checks if the word is a variable or not by
using(nonvar(W)), if the word is not a variable and “done” the user stops adding to the
knowledge base, else if it’s not a variable and not done it reads what the user entered and
asserts it into the knowledge base. Else if the word is a variable it writes a message to the user,
and repeats the add predicate again.
- is_category(C):- succeeds if C is one of the available categories in the knowledge base.
- categories(L):- succeeds if L is a list that contains all the categories in the knowledge base
without repetitions.

- available_length(L):- succeeds if a word in the knowledge base has length L.

- pick_word(W,L,C):- succeeds if the word W matches a word in the knowledge base with
length L and category C.

- remove_duplicates(L,L1):- takes two lists, it binds L1 to an empty list if L is empty(base
case). First rule checks if the H (head) of the first list is not a member in T (tail), puts it in the
second list L1 and calls remove_duplicates(T,T1) with the two tails of the two lists. Second rule
checks if H (head) of the first list is a member in T(tail), removes it and calls
remove_duplicates(T,L1) with the tail of the first list and with the second list.

- correct_letters(L1,L2,CL):- succeeds if CL is the intersection list after removing duplicates
by remove_duplicates(X,Y) between the two lists (first list L1 is the word entered by the user
and the second list L2 is the random word selected by the game).

- correct_positions(L,L1,L2):-
This predicate takes 3 lists as parameters. It terminates when the first two lists are empty, then it
binds the resulting list to an empty list (base case). Otherwise, it checks if the heads H of the
first two lists (L and L1) are the same, then this head is added to the resulting list (L2) then
correct_positions(T1,T2,T3) calls the predicate recursively with the tails of all three lists.
Otherwise, if the head of the first list H1 and the head of the second list H2 are unequal, these
elements are ignored and correct_positions(T1,T2,PL) calls the predicate recursively with the
tails of the first two lists(T1 and T2) without changing the resulting list (PL).

- choose_category(C):-
C is the correct category that the user will choose.
This predicate takes input category from the user, and if an invalid category is entered it keeps
reading inputs till a valid category is reached.
It prompts the user to enter a category (variable M), then checks if M is not a valid category
using \+is_category(M), it displays an error message “This category does not exist.” and calls
the method recursively. Otherwise, it checks if M is a valid category, then C is bound to M,
where C is the valid category variable.
- read_number(N):-
N is the read integer.
The aim of this predicate is to ensure that the read value is an integer.
It prompts the user to enter a value (variable X), then checks if X is not an integer using
\+number(X), then it displays an error message “This is not a valid number! Try again”, and
calls the method recursively. Otherwise, it checks if X is a valid number then N is bound to X,
where N is a valid integer.

- choose_length(L,C,G):-
L is the length of the correct word to be guessed.
C is the category of the correct word to be guessed.
G is the number of initial guesses.
This predicate takes an input length from the user, and if an invalid length is entered, i.e the
entered length does not exist in the chosen category C, it keeps reading inputs till a valid length
is entered.
It prompts the user to enter a value (variable X), using read_number(X), which ensures that X
is an integer. It checks if a word exists in this category C with length X using word_length(X,C),
then it binds L to X, and displays a message stating that the game started, with number of initial
guesses G, where G is L+1. Otherwise, if no word exists in this category C with length X, the
message “There are no words of this length.” is displayed and the method is called recursively
again to find a valid length.

- word_checker(K):-
K is the entered word.
This predicate checks if this word is available in the knowledge base or not.
- read_guess(L,G,X) :-
L is the length of the word to be guessed
G is the number of guesses left
K is the entered guess .
The aim of this predicate is to check if the guess is of correct length.
The predicate reads the user’s guess X and checks if the length of this guess is the same as L if
not an error message is printed and the user is asked to enter a guess again else the entered
word is accepted.
- kb_len_read(L,G,K):-
L is the length of the word to be guessed
G is the number of guesses left
K is the entered guess.
The aim of this predicate is to check that the word K is in the knowledge base.

The predicate calls read_guess(L,G,X) first to check if the entered word X is composed of the
correct length L. If the word is of correct length, word_checker(X) is called with the entered
word X to check if it’s in the knowledge base or not. If it is in the KB the entered word is
accepted, else an error message is printed and the user is asked to enter a word again.
- guess(L,G,R):-
L is the length of the word to be guessed
G is the number of guesses left
R is the word to be guessed.
The predicate calls :
kb_len_read(L,G,K) to check if the word is with correct length and is available in the KB.
string_chars(K,KL) : converts the string guessed word K to a list of the characters KL.
string_chars(R,RL) : converts the string word to be guessed R to a list of the characters RL.
correct_letters(KL,RL,CL) : to check if the list KL of the guessed word has common letters
without duplicates with the list of words to be guessed RL.
correct_positions(KL,RL,CP) : to check if the list KL of the guessed word has common letters
in correct positions with the list of the word to be guessed RL.
If the guess is accepted the number of guesses G is reduced to G1.
Then win (L, CP) is called to check if the entered word is the word to be guessed, if so the user
wins else if the user didn’t win and the guesses is zero the user loses, else the correct letters
and the correct letters in correct positions are printed to the user as well as the remaining
guesses and the user is asked to enter a guess again and guess(L, G1, R) is called with the
new number of guesses G1.

- win(L,CP):-
L is the length of the correct word to be guessed.
CP is a list of all the characters in the Correct Positions.
The aim of this predicate is to check if the player won.
This predicate uses the built-in predicate length(CP,L) to return true if the length of list CP is L
and writes ‘You Won!’ as a result.

- word_length(L,C):-
L is the length input by the player & of the correct word to be guessed.
C is the category which was picked by the player initially (& the correct word belongs to).
W is a word in the category C.
The aim of this predicate is to check if a word of length L is found in category C.
This predicate uses word(W,C) to return the word W and checks if the length of the word W is
the same as length L using the built-in predicate string_length(W,L).

- play:-
Ctg is a list of all the categories created in the build knowledge base phase.
C is the chosen category.
L is the chosen length.
G is the number of available guesses initially.
WordList is a list containing all the words W with the chosen length L in the chosen category C.
R is a random word from WordList.
The aim of this predicate is to start the process of playing the game.
This predicate starts off by writing ‘The available categories are: ’ and uses the predicate
categories(Ctg) to return the list of available categories in the knowledge base called Ctg.
The list Ctg is then written. The predicate choose_category(C) is then used to allow the user to
choose a valid category C, followed by the predicate choose_length(L,C,G) which allows the
user to choose a valid length L and returns the initial number of available guesses G. The
predicate setof(W, pick_word(W,L,C), WordList) is then used to return a list WordList
composed of all the words W with the chosen length L in the chosen category C. The built-in
predicate random_member(R,WordList) was used to select a random word R from WordList.
Finally the player starts to guess the previously selected word R so the predicate guess(L,G,R)
is called.
- main:-
The aim of this predicate is to start the knowledge base building phase followed by starting the
playing phase.
This predicate starts by calling the predicate build_kb, then calling the predicate play.

## Screenshots of gameplay
<details>
  <summary>
    <h3>
      Winning Case
    </h3>
  </summary>
  <img width="1000" alt="winning" src="Screenshot 2024-03-30 004011.png">
  <img width="1000" alt="winning" src="Screenshot 2024-03-30 004022.png">

</details>
