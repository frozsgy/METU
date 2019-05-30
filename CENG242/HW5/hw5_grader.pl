:- module(hw5_grader, [runGrader/1]).

% ===== READ ME =====
% 1. Run the grader with the following command;
%		swipl -S4096m -q -s hw5_grader.pl -t "runGrader('./FILENAME.pl')"
% where FILENAME.pl is your code file.
% Note: You may need 4 gbs of memory space to run this command.
% If you don't, remove or change the option "-S4096m".
%
% 2. In order to make Prolog print the whole list when a long list is returned with dots, call the following:
% 		set_prolog_flag(answer_write_options,[max_depth(0)]).

% === Helper functions ===
%write_comment(_).
% Replace the above definition with the below one to see the comments
write_comment(Comment) :- write(Comment).

is_subset([], _).
is_subset([H|T], Y):- member(H, Y), select(H, Y, Z), is_subset(T, Z).
equal(X, Y):- is_subset(X, Y), is_subset(Y, X), !.



% === Test cases for catomic_number/2 ===
test_case_CN1(G) :- (not(catomic_number(_, 19))) 
			-> G is 1, write_comment('- Test case 1 is successful.\n'); G is 0, write_comment('- Test case 1 is failed.\n').
test_case_CN2(G) :- (catomic_number(c235, 91), not(catomic_number(c235, 90))) 
			-> G is 1, write_comment('- Test case 2 is successful.\n'); G is 0, write_comment('- Test case 2 is failed.\n').
test_case_CN3(G) :- (catomic_number(NAME, 38), !, NAME == c922) 
			-> G is 1, write_comment('- Test case 3 is successful.\n'); G is 0, write_comment('- Test case 3 is failed.\n').
test_case_CN4(G) :- (catomic_number(c925, CATOMIC_NUMBER), !, CATOMIC_NUMBER == 83)
			-> G is 1, write_comment('- Test case 4 is successful.\n'); G is 0, write_comment('- Test case 4 is failed.\n').
test_case_CN5(G) :- (findall(CATOMIC_NUMBER, catomic_number(c865, CATOMIC_NUMBER), ALL_CN), equal(ALL_CN, [177]) )
			-> G is 1, write_comment('- Test case 5 is successful.\n'); G is 0, write_comment('- Test case 5 is failed.\n').
test_case_CN6(G) :- (findall(NAME, catomic_number(NAME, 197), ALL_NAMES), equal(ALL_NAMES, [c704]) )
			-> G is 1, write_comment('- Test case 6 is successful.\n'); G is 0, write_comment('- Test case 6 is failed.\n').
test_case_CN7(G) :- (findall(CATOMIC_NUMBER, catomic_number(_, CATOMIC_NUMBER), ALL_CN), equal(ALL_CN, [249,244,235,230,224,212,211,209,204,199,197,192,190,188,177,176,175,165,164,155,151,141,138,133,125,121,116,108,106,98,94,93,91,83,81,79,63,62,61,58,54,46,44,40,38,28,27,24,23,20]) )
			-> G is 2, write_comment('- Test case 7 is successful.\n'); G is 0, write_comment('- Test case 7 is failed.\n').
test_case_CN8(G) :- (findall(NAME, catomic_number(NAME, _), ALL_NAMES), equal(ALL_NAMES, [c236,c680,c510,c598,c982,c840,c161,c589,c187,c860,c704,c995,c2,c162,c865,c10,c491,c787,c628,c90,c620,c120,c546,c519,c430,c461,c30,c624,c900,c221,c817,c792,c235,c925,c723,c753,c779,c17,c572,c971,c500,c405,c678,c758,c922,c279,c22,c201,c452,c332]) )
			-> G is 2, write_comment('- Test case 8 is successful.\n'); G is 0, write_comment('- Test case 8 is failed.\n').			

testCN(0) :-
    not(current_predicate(catomic_number/2)), 
    !,
	write_comment('- Predicate catomic_number/2 is not found.\n').

testCN(Grade) :-
    TimeLimit is 5, 
	catch(call_with_time_limit(TimeLimit, test_case_CN1(G1)), _, (G1 is 0, write_comment('- Test case 1 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_CN2(G2)), _, (G2 is 0, write_comment('- Test case 2 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_CN3(G3)), _, (G3 is 0, write_comment('- Test case 3 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_CN4(G4)), _, (G4 is 0, write_comment('- Test case 4 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_CN5(G5)), _, (G5 is 0, write_comment('- Test case 5 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_CN6(G6)), _, (G6 is 0, write_comment('- Test case 6 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_CN7(G7)), _, (G7 is 0, write_comment('- Test case 7 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_CN8(G8)), _, (G8 is 0, write_comment('- Test case 8 timed out.\n'))), 
	Grade is G1 + G2 + G3 + G4 + G5 + G6 + G7 + G8.

% === Test cases for ion/2 ===
test_case_I1(G) :- (findall(CHARGE, ion(_, CHARGE), ALL_C), min_list(ALL_C, -3), max_list(ALL_C, 4)) 
			-> G is 2, write_comment('- Test case 1 is successful.\n'); G is 0, write_comment('- Test case 1 is failed.\n').
test_case_I2(G) :- ( findall(CHARGE, ion(c922, CHARGE), ALL_C), equal(ALL_C, [-2]) )
			-> G is 2, write_comment('- Test case 2 is successful.\n'); G is 0, write_comment('- Test case 2 is failed.\n').
test_case_I3(G) :- (ion(c235, 4), not(ion(c235, -4)))
			-> G is 2, write_comment('- Test case 3 is successful.\n'); G is 0, write_comment('- Test case 3 is failed.\n').
test_case_I4(G) :- ( findall(NAME, ion(NAME, -3), ALL_NAMES), equal(ALL_NAMES, [c680,c589,c187,c995,c628,c620,c546,c30,c572,c500,c279,c332]) )
			-> G is 2, write_comment('- Test case 4 is successful.\n'); G is 0, write_comment('- Test case 4 is failed.\n').
test_case_I5(G) :- ( findall(NAME, ion(NAME, -2), ALL_NAMES), equal(ALL_NAMES, [c236,c840,c120,c779,c678,c922]) )
			-> G is 2, write_comment('- Test case 5 is successful.\n'); G is 0, write_comment('- Test case 5 is failed.\n').
test_case_I6(G) :- ( findall(NAME, ion(NAME, -1), ALL_NAMES), equal(ALL_NAMES, [c510,c598,c162,c430,c792,c753,c201]) )
			-> G is 2, write_comment('- Test case 6 is successful.\n'); G is 0, write_comment('- Test case 6 is failed.\n').
test_case_I7(G) :- ( findall(NAME, ion(NAME, 0), ALL_NAMES), equal(ALL_NAMES, []) )
			-> G is 2, write_comment('- Test case 7 is successful.\n'); G is 0, write_comment('- Test case 7 is failed.\n').
test_case_I8(G) :- ( findall(NAME, ion(NAME, 1), ALL_NAMES), equal(ALL_NAMES, [c982,c723,c17,c452]) )
			-> G is 2, write_comment('- Test case 8 is successful.\n'); G is 0, write_comment('- Test case 8 is failed.\n').
test_case_I9(G) :- ( findall(NAME, ion(NAME, 2), ALL_NAMES), equal(ALL_NAMES, [c161,c865,c787,c900,c925,c971,c22]) )
			-> G is 2, write_comment('- Test case 9 is successful.\n'); G is 0, write_comment('- Test case 9 is failed.\n').
test_case_I10(G) :- ( findall(NAME, ion(NAME, 3), ALL_NAMES), equal(ALL_NAMES, [c2,c10,c519,c624,c221,c817,c758]) )
			-> G is 2, write_comment('- Test case 10 is successful.\n'); G is 0, write_comment('- Test case 10 is failed.\n').			

testI(0) :-
    not(current_predicate(ion/2)), 
    !,
	write_comment('- Predicate ion/2 is not found.\n').

testI(Grade) :-
    TimeLimit is 5, 
	catch(call_with_time_limit(TimeLimit, test_case_I1(G1)), _, (G1 is 0, write_comment('- Test case 1 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_I2(G2)), _, (G2 is 0, write_comment('- Test case 2 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_I3(G3)), _, (G3 is 0, write_comment('- Test case 3 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_I4(G4)), _, (G4 is 0, write_comment('- Test case 4 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_I5(G5)), _, (G5 is 0, write_comment('- Test case 5 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_I6(G6)), _, (G6 is 0, write_comment('- Test case 6 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_I7(G7)), _, (G7 is 0, write_comment('- Test case 7 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_I8(G8)), _, (G8 is 0, write_comment('- Test case 8 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_I9(G9)), _, (G9 is 0, write_comment('- Test case 9 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_I10(G10)), _, (G10 is 0, write_comment('- Test case 10 timed out.\n'))),
	Grade is G1 + G2 + G3 + G4 + G5 + G6 + G7 + G8 + G9 + G10.


% === Test cases for molecule/2 ===
test_case_M1(G) :- (not(molecule(_, 30))) 
			-> G is 5, write_comment('- Test case 1 is successful.\n'); G is 0, write_comment('- Test case 1 is failed.\n').
test_case_M2(G) :- (molecule(CATOM_LIST, 47), CATOM_LIST == [c452, c201]) 
			-> G is 5, write_comment('- Test case 2 is successful.\n'); G is 0, write_comment('- Test case 2 is failed.\n').
test_case_M3(G) :- (molecule(CATOM_LIST, 70), CATOM_LIST == [c332,c452,c22]) 
			-> G is 6, write_comment('- Test case 3 is successful.\n'); G is 0, write_comment('- Test case 3 is failed.\n').
test_case_M4(G) :- ( findall(CATOM_LIST, molecule(CATOM_LIST, 90), ALL_MOLECULES), equal(ALL_MOLECULES, [[c332,c201,c405],[c22,c779],[c452,c452,c678]]) )
			-> G is 6, write_comment('- Test case 4 is successful.\n'); G is 0, write_comment('- Test case 4 is failed.\n').
test_case_M5(G) :- (molecule(CATOM_LIST, 98), CATOM_LIST == [c332,c201,c22,c22]) 
			-> G is 7, write_comment('- Test case 5 is successful.\n'); G is 0, write_comment('- Test case 5 is failed.\n').
test_case_M6(G) :- (not(molecule(_, 100))) 
			-> G is 7, write_comment('- Test case 6 is successful.\n'); G is 0, write_comment('- Test case 6 is failed.\n').
test_case_M7(G) :- (molecule(CATOM_LIST, 107), CATOM_LIST == [c332,c452,c201,c758]) 
			-> G is 7, write_comment('- Test case 7 is successful.\n'); G is 0, write_comment('- Test case 7 is failed.\n').
test_case_M8(G) :- ( findall(CATOM_LIST, molecule(CATOM_LIST, 137), ALL_MOLECULES), equal(ALL_MOLECULES, [[c201,c22,c279,c971],[c332,c452,c201,c201,c405],[c452,c201,c22,c779],[c452,c452,c452,c201,c678],[c22,c22,c22,c279,c279]]) )
			-> G is 7, write_comment('- Test case 8 is successful.\n'); G is 0, write_comment('- Test case 8 is failed.\n').
test_case_M9(G) :- ( findall(CATOM_LIST, molecule(CATOM_LIST, 222), ALL_MOLECULES), equal(ALL_MOLECULES, [[c332,c332,c22,c90],[c922,c779,c461],[c332,c22,c500,c461],[c201,c279,c17,c624],[c332,c758,c500,c624],[c332,c452,c452,c201,c201,c624],[c500,c17,c900],[c201,c201,c279,c758,c900],[c452,c22,c279,c922,c900],[c279,c922,c971,c221],[c452,c922,c779,c221],[c332,c452,c22,c500,c221],[c332,c201,c758,c678,c817],[c332,c279,c925,c235],[c332,c452,c922,c971,c925],[c332,c201,c22,c279,c758,c925],[c922,c758,c572,c925],[c201,c22,c279,c17,c723],[c332,c452,c452,c201,c201,c22,c723],[c922,c758,c779,c723],[c332,c22,c758,c500,c723],[c332,c922,c758,c17,c17],[c452,c452,c201,c279,c17,c17],[c332,c332,c279,c405,c405,c17],[c332,c332,c332,c22,c22,c405,c17],[c201,c279,c279,c758,c758,c17],[c332,c452,c452,c758,c500,c17],[c201,c22,c22,c922,c678,c17],[c332,c452,c452,c452,c452,c201,c201,c17],[c332,c279,c971,c971,c971],[c332,c332,c452,c22,c279,c405,c971],[c332,c332,c332,c452,c22,c22,c22,c971],[c332,c332,c758,c758,c678,c971],[c332,c201,c201,c201,c922,c405,c405],[c332,c332,c332,c452,c452,c201,c405,c405],[c332,c332,c452,c452,c452,c452,c678,c405],[c452,c452,c201,c201,c922,c678,c405],[c332,c332,c201,c922,c758,c758,c758],[c332,c452,c452,c201,c201,c279,c758,c758],[c332,c452,c452,c452,c22,c279,c922,c758],[c452,c925,c30],[c452,c201,c201,c971,c792],[c452,c201,c22,c22,c279,c792],[c332,c332,c452,c758,c758,c753],[c22,c922,c922,c758,c753],[c201,c758,c753,c753],[c332,c452,c971,c971,c779],[c332,c332,c452,c452,c22,c405,c779],[c201,c201,c22,c922,c405,c779],[c758,c971,c572,c779],[c201,c22,c22,c22,c500,c779],[c332,c22,c279,c758,c405,c572],[c332,c332,c22,c22,c22,c758,c572],[c452,c452,c22,c22,c572,c572],[c201,c201,c279,c405,c405,c500],[c332,c201,c201,c22,c22,c405,c500],[c922,c758,c678,c405,c500],[c332,c279,c758,c758,c758,c500],[c452,c452,c201,c22,c22,c678,c500],[c452,c22,c758,c678,c678,c678],[c452,c452,c452,c452,c452,c201,c22,c279,c279]]) )
			-> G is 10, write_comment('- Test case 9 is successful.\n'); G is 0, write_comment('- Test case 9 is failed.\n').
test_case_M10(G) :- ( findall(CATOM_LIST, molecule(CATOM_LIST, 265), ALL_MOLECULES), equal(ALL_MOLECULES, [[c452,c201,c279,c2],[c332,c201,c201,c201,c758,c519],[c22,c678,c572,c519],[c452,c22,c279,c500,c519],[c332,c452,c201,c22,c922,c519],[c332,c332,c452,c723,c461],[c279,c922,c922,c758,c461],[c922,c922,c723,c624],[c452,c279,c678,c17,c624],[c332,c201,c22,c279,c971,c624],[c22,c279,c279,c279,c405,c624],[c332,c332,c452,c201,c201,c405,c624],[c332,c452,c201,c22,c779,c624],[c922,c971,c572,c624],[c332,c452,c452,c452,c201,c678,c624],[c332,c22,c22,c22,c279,c279,c624],[c922,c922,c925,c900],[c332,c22,c500,c971,c900],[c332,c22,c279,c922,c405,c900],[c332,c452,c452,c792,c900],[c922,c971,c779,c900],[c452,c201,c201,c22,c572,c900],[c452,c201,c279,c758,c678,c900],[c332,c332,c22,c22,c22,c922,c900],[c332,c332,c452,c452,c723,c221],[c201,c201,c922,c723,c221],[c452,c279,c922,c922,c758,c221],[c332,c922,c405,c779,c221],[c201,c201,c971,c572,c221],[c201,c22,c22,c279,c572,c221],[c332,c332,c22,c405,c500,c221],[c22,c279,c279,c758,c678,c221],[c201,c279,c279,c235,c817],[c22,c279,c500,c17,c817],[c332,c201,c22,c922,c17,c817],[c452,c201,c279,c922,c971,c817],[c201,c201,c22,c279,c279,c758,c817],[c452,c452,c201,c922,c779,c817],[c332,c452,c452,c201,c22,c500,c817],[c332,c452,c758,c678,c678,c817],[c452,c22,c22,c279,c279,c922,c817],[c332,c332,c332,c452,c235,c235],[c452,c279,c572,c17,c235],[c201,c678,c678,c17,c235],[c332,c279,c279,c758,c971,c235],[c201,c922,c500,c971,c235],[c201,c279,c922,c922,c405,c235],[c332,c332,c332,c452,c201,c22,c758,c235],[c332,c201,c201,c22,c753,c235],[c332,c452,c279,c758,c779,c235],[c332,c452,c452,c452,c201,c572,c235],[c22,c22,c279,c922,c500,c235],[c332,c201,c22,c22,c922,c922,c235],[c452,c201,c201,c201,c201,c22,c279,c235],[c332,c753,c925,c925],[c452,c201,c201,c279,c925,c925],[c452,c201,c500,c723,c925],[c332,c332,c922,c405,c971,c925],[c201,c201,c678,c678,c405,c925],[c332,c452,c452,c922,c922,c758,c925],[c452,c201,c279,c405,c572,c925],[c332,c452,c201,c22,c22,c572,c925],[c332,c452,c22,c279,c758,c678,c925],[c452,c452,c452,c452,c201,c279,c922,c925],[c332,c332,c452,c758,c723,c723],[c201,c753,c723,c723],[c22,c922,c922,c723,c723],[c452,c22,c279,c678,c17,c723],[c452,c452,c922,c922,c17,c723],[c332,c201,c201,c971,c971,c723],[c201,c279,c279,c405,c971,c723],[c332,c201,c22,c22,c279,c971,c723],[c332,c332,c452,c201,c201,c22,c405,c723],[c22,c22,c279,c279,c279,c405,c723],[c279,c922,c922,c758,c758,c723],[c452,c201,c279,c405,c779,c723],[c332,c452,c201,c22,c22,c779,c723],[c22,c922,c971,c572,c723],[c452,c405,c500,c572,c723],[c452,c452,c452,c452,c922,c500,c723],[c332,c452,c452,c452,c201,c22,c678,c723],[c332,c22,c22,c22,c22,c279,c279,c723],[c22,c279,c279,c971,c17,c17],[c332,c452,c201,c279,c405,c17,c17],[c332,c332,c452,c201,c22,c22,c17,c17],[c452,c452,c452,c279,c678,c17,c17],[c332,c332,c22,c922,c758,c971,c17],[c332,c452,c452,c201,c22,c279,c971,c17],[c452,c201,c201,c201,c201,c922,c405,c17],[c452,c452,c22,c279,c279,c279,c405,c17],[c332,c332,c452,c452,c452,c201,c201,c405,c17],[c452,c452,c922,c971,c572,c17],[c452,c201,c22,c279,c758,c572,c17],[c332,c332,c452,c758,c405,c500,c17],[c22,c922,c922,c405,c500,c17],[c452,c201,c201,c201,c22,c22,c500,c17],[c452,c279,c279,c758,c758,c678,c17],[c201,c201,c22,c758,c678,c678,c17],[c452,c22,c22,c922,c678,c678,c17],[c332,c452,c452,c452,c452,c452,c201,c678,c17],[c332,c452,c452,c22,c22,c22,c279,c279,c17],[c332,c452,c279,c922,c758,c971,c971],[c201,c22,c678,c500,c971,c971],[c452,c452,c452,c201,c279,c279,c971,c971],[c332,c332,c332,c22,c279,c405,c405,c971],[c332,c332,c332,c332,c22,c22,c22,c405,c971],[c201,c22,c279,c922,c678,c405,c971],[c452,c201,c922,c922,c922,c405,c971],[c332,c201,c22,c279,c279,c758,c758,c971],[c452,c201,c201,c201,c201,c201,c201,c758,c971],[c332,c332,c452,c452,c452,c452,c201,c201,c22,c971],[c332,c332,c452,c452,c22,c758,c500,c971],[c201,c201,c22,c922,c758,c500,c971],[c22,c22,c22,c279,c678,c500,c971],[c452,c22,c22,c922,c922,c500,c971],[c332,c201,c22,c22,c22,c922,c678,c971],[c452,c452,c201,c201,c201,c201,c22,c922,c971],[c452,c452,c452,c22,c22,c279,c279,c279,c971],[c332,c332,c332,c332,c452,c201,c405,c405,c405],[c332,c332,c332,c452,c452,c452,c678,c405,c405],[c332,c452,c201,c201,c922,c678,c405,c405],[c22,c279,c279,c279,c279,c758,c758,c405],[c332,c332,c452,c201,c201,c279,c758,c758,c405],[c201,c201,c22,c279,c922,c922,c758,c405],[c332,c332,c452,c452,c22,c279,c922,c758,c405],[c332,c22,c758,c678,c678,c678,c405],[c452,c452,c452,c201,c922,c678,c678,c405],[c22,c22,c22,c279,c279,c922,c678,c405],[c452,c22,c22,c279,c922,c922,c922,c405],[c332,c452,c452,c452,c452,c201,c22,c279,c279,c405],[c332,c332,c332,c452,c201,c201,c22,c22,c758,c758],[c332,c22,c22,c22,c279,c279,c279,c758,c758],[c332,c332,c332,c452,c452,c22,c22,c22,c922,c758],[c332,c201,c201,c22,c22,c22,c922,c922,c758],[c452,c201,c201,c201,c201,c201,c22,c22,c279,c758],[c22,c279,c405,c628],[c332,c22,c22,c22,c628],[c17,c17,c120],[c332,c201,c758,c758,c120],[c452,c452,c452,c22,c279,c120],[c452,c452,c723,c546],[c22,c405,c500,c546],[c452,c22,c279,c17,c430],[c332,c452,c452,c452,c201,c22,c430],[c332,c405,c925,c30],[c332,c22,c758,c17,c30],[c452,c279,c758,c971,c30],[c452,c452,c758,c779,c30],[c201,c22,c22,c22,c678,c30],[c201,c22,c922,c925,c792],[c332,c201,c201,c405,c971,c792],[c452,c452,c201,c678,c971,c792],[c201,c279,c279,c405,c405,c792],[c332,c201,c22,c22,c279,c405,c792],[c332,c332,c452,c452,c452,c452,c758,c792],[c452,c452,c201,c201,c922,c758,c792],[c332,c332,c201,c22,c22,c22,c22,c792],[c452,c452,c452,c201,c753,c792],[c201,c22,c971,c779,c792],[c22,c22,c22,c279,c779,c792],[c22,c922,c405,c572,c792],[c922,c758,c758,c500,c792],[c452,c452,c22,c22,c279,c678,c792],[c452,c452,c452,c22,c922,c922,c792],[c201,c405,c500,c17,c753],[c452,c201,c22,c500,c971,c753],[c758,c678,c678,c971,c753],[c332,c332,c332,c758,c758,c405,c753],[c201,c201,c201,c279,c758,c405,c753],[c452,c201,c22,c279,c922,c405,c753],[c332,c201,c201,c201,c22,c22,c758,c753],[c452,c758,c678,c753,c753],[c22,c22,c22,c678,c572,c753],[c452,c22,c22,c22,c279,c500,c753],[c201,c922,c758,c758,c678,c753],[c332,c452,c201,c22,c22,c22,c922,c753],[c452,c22,c279,c17,c17,c779],[c332,c452,c452,c452,c201,c22,c17,c779],[c332,c332,c405,c971,c971,c779],[c332,c452,c452,c922,c758,c971,c779],[c452,c452,c452,c452,c201,c279,c971,c779],[c332,c332,c332,c452,c22,c405,c405,c779],[c201,c201,c201,c758,c678,c405,c779],[c452,c201,c22,c922,c678,c405,c779],[c332,c452,c201,c22,c279,c758,c758,c779],[c452,c452,c452,c452,c452,c201,c779,c779],[c452,c922,c758,c758,c572,c779],[c452,c22,c22,c22,c678,c500,c779],[c452,c452,c452,c452,c22,c22,c279,c279,c779],[c279,c922,c758,c758,c971,c572],[c452,c452,c452,c452,c500,c971,c572],[c201,c678,c678,c405,c405,c572],[c452,c452,c452,c452,c279,c922,c405,c572],[c332,c452,c452,c452,c201,c201,c22,c758,c572],[c22,c971,c971,c572,c572],[c452,c279,c405,c405,c572,c572],[c332,c452,c22,c22,c405,c572,c572],[c332,c452,c22,c758,c758,c500,c572],[c332,c452,c452,c452,c452,c22,c22,c922,c572],[c452,c201,c279,c678,c405,c405,c500],[c332,c452,c201,c22,c22,c678,c405,c500],[c452,c452,c452,c201,c201,c201,c201,c405,c500],[c201,c22,c22,c22,c279,c922,c758,c500],[c452,c201,c201,c758,c405,c500,c500],[c452,c452,c22,c922,c405,c500,c500],[c452,c452,c452,c22,c22,c678,c678,c500],[c332,c332,c452,c922,c758,c758,c758,c678],[c22,c922,c922,c922,c758,c758,c678],[c332,c452,c452,c452,c201,c279,c758,c758,c678],[c332,c22,c22,c22,c22,c22,c279,c922,c678],[c452,c452,c452,c452,c452,c452,c22,c279,c279,c678],[c332,c452,c22,c22,c22,c22,c922,c922,c922],[c452,c452,c452,c452,c452,c452,c452,c279,c922,c922],[c452,c452,c201,c201,c201,c22,c22,c22,c279,c922],[c332,c332,c452,c452,c452,c452,c201,c22,c22,c22,c279]] ) )
			-> G is 10, write_comment('- Test case 10 is successful.\n'); G is 0, write_comment('- Test case 10 is failed.\n').			

testM(0) :-
    not(current_predicate(molecule/2)), 
    !,
	write_comment('- Predicate molecule/2 is not found.\n').

testM(Grade) :-
    TimeLimit is 20, 
	ExtendedTimeLimit is 120,
	catch(call_with_time_limit(TimeLimit, test_case_M1(G1)), _, (G1 is 0, write_comment('- Test case 1 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_M2(G2)), _, (G2 is 0, write_comment('- Test case 2 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_M3(G3)), _, (G3 is 0, write_comment('- Test case 3 timed out.\n'))),
	catch(call_with_time_limit(TimeLimit, test_case_M4(G4)), _, (G4 is 0, write_comment('- Test case 4 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_M5(G5)), _, (G5 is 0, write_comment('- Test case 5 timed out.\n'))), 
	catch(call_with_time_limit(TimeLimit, test_case_M6(G6)), _, (G6 is 0, write_comment('- Test case 6 timed out.\n'))),
	catch(call_with_time_limit(ExtendedTimeLimit, test_case_M7(G7)), _, (G7 is 0, write_comment('- Test case 7 timed out.\n'))), 
	catch(call_with_time_limit(ExtendedTimeLimit, test_case_M8(G8)), _, (G8 is 0, write_comment('- Test case 8 timed out.\n'))), 
	catch(call_with_time_limit(ExtendedTimeLimit, test_case_M9(G9)), _, (G9 is 0, write_comment('- Test case 9 timed out.\n'))),
	catch(call_with_time_limit(ExtendedTimeLimit, test_case_M10(G10)), _, (G10 is 0, write_comment('- Test case 10 timed out.\n'))),
	Grade is G1 + G2 + G3 + G4 + G5 + G6 + G7 + G8 + G9 + G10.

testHW :-
    write_comment('Testing catomic_number/2 predicate...\n'),
    testCN(CN_G),
	write_comment('Testing ion/2 predicate...\n'),
	testI(I_G),
	write_comment('Testing molecule/2 predicate...\n'),
	testM(M_G),
    Grade is CN_G + I_G + M_G,
    write(Grade).    


runGrader(File) :- 
	use_module(File),
	catch(call_with_time_limit(800, testHW), _, _).

