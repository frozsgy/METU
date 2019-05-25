import Hw2


help = putStrLn "try \"test 1\" for isNumber, \"test 2\" for eagerEvaluation and \"test 3\" for normalEvaluation. \ntry \"test 29\" for eagerEvaluation with erroneous inputs, and \"test 39\" for normalEvaluation with erroneous inputs. \"test 0\" does magical things"


checker' :: ([Bool], [Bool], Int) -> String

checker'' :: ([ASTResult], [ASTResult], Int) -> String




checker' (l1, l2, x) | x == (length l1) = ""




checker' (l1, l2, x) | (length l1) /= (length l2) = "ERROR: input and output numbers don't match!"
                     | (length l1) == 0 = "nothing to test"
                     | x == (length l1) = ""
                     | (l1!!x == l2!!x) = "test case " ++ (show x) ++ " passed :D \n"  ++ checker' (l1, l2, (x+1))
                     | (l1!!x /= l2!!x) = "test case " ++ (show x) ++ " failed :( \n" ++ checker' (l1, l2, (x+1))

checker'' (l1, l2, x) | (length l1) /= (length l2) = "ERROR: input and output numbers don't match!"
                      | (length l1) == 0 = "nothing to test"
                      | x == (length l1) = ""
                      | ((show (l1!!x)) == (show (l2!!x))) = "test case " ++ (show x) ++ " passed :D \n"  ++ checker'' (l1, l2, (x+1))
                      | ((show (l1!!x)) /= (show (l2!!x))) = "test case " ++ (show x) ++ " failed :( \n" ++ checker'' (l1, l2, (x+1))


--you may manually add or remove test cases here
isNumIn = [" 24 7", "1923", "number", "CENG242", "242CENG", "-789", "1a2b3c", "q4w5r6", "3.14", "-18.5"]
isNumOut = [False, True, False, False, False, True, False, False, False, False]

eagerEvalIn = [
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "plus") ((ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "20") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "19") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "Spr") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "ing") EmptyAST EmptyAST) EmptyAST)) EmptyAST)) EmptyAST)) ((ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CE") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "NG") EmptyAST EmptyAST) EmptyAST)) EmptyAST)) EmptyAST))) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)))),
                (ASTNode (ASTLetDatum "x") ((ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST)) EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)) (ASTNode (ASTLetDatum "z") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "z") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST)))) )),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "10") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "plus")(ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST))),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "10") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST))) (ASTNode (ASTLetDatum "z") (ASTNode (ASTSimpleDatum "plus")(ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)) (ASTNode (ASTSimpleDatum "plus")(ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "z") EmptyAST EmptyAST)))),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "4") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "5") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST))))),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "7") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) ((ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "HELLO") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) EmptyAST)))) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST)) (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "40") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) EmptyAST)) EmptyAST))))
               ]
eagerEvalOut = [
                (ASTJust ("121032","num",13)),
                (ASTJust ("-14742","num",9)),
                (ASTJust ("-53","num",6)),
                (ASTJust ("90","num",3)),
                (ASTJust ("85","num",8)),
                (ASTJust ("6783","num",9))
                ]

normalEvalIn = [
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "plus") ((ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "20") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "19") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "Spr") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "ing") EmptyAST EmptyAST) EmptyAST)) EmptyAST)) EmptyAST)) ((ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CE") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "NG") EmptyAST EmptyAST) EmptyAST)) EmptyAST)) EmptyAST))) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)))),
                (ASTNode (ASTLetDatum "x") ((ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST)) EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)) (ASTNode (ASTLetDatum "z") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "z") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST)))) )),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "10") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "plus")(ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST))),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "10") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST))) (ASTNode (ASTLetDatum "z") (ASTNode (ASTSimpleDatum "plus")(ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)) (ASTNode (ASTSimpleDatum "plus")(ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "z") EmptyAST EmptyAST)))),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "4") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "5") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST))))),
                (ASTNode (ASTLetDatum "x") (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "7") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) ((ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "HELLO") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) EmptyAST)))) (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "y") EmptyAST EmptyAST)) (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTLetDatum "y") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "40") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) EmptyAST)) EmptyAST))))
                 ]
normalEvalOut = [
                (ASTJust ("121032","num",35)),
                (ASTJust ("-14742","num",25)),
                (ASTJust ("-53","num",7)),
                (ASTJust ("90","num",5)),
                (ASTJust ("85","num",10)),
                (ASTJust ("6783","num",12))
                 ]

--eager and normal evaluation must have same outputs for errors, as stated in error_handling.txt
funErrIn1 = [
            (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1a") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "17") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "17") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "17") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST)),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "len")(ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST)),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST) EmptyAST)),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST) EmptyAST)),
            (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2019") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "number") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2019") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "number") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)))

            ]

funErrOut1 = [
             (ASTError "the value '1a' is not a number!"),
             (ASTError "times operation is not defined between str and num!"),
             (ASTError "times operation is not defined between str and str!"),
             (ASTError "cat operation is not defined between str and num!"),
             (ASTError "cat operation is not defined between num and num!"),
             (ASTError "len operation is not defined on num!"),
             (ASTError "negate operation is not defined on str!"),
             (ASTError "times operation is not defined between num and str!"),
             (ASTError "times operation is not defined between num and str!")
             
             ]

funErrIn2 = [
            (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "1a") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "17") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "17") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "14") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "17") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST)),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "len")(ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST)),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST) EmptyAST)),
            (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "negate") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "3") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "12") EmptyAST EmptyAST) EmptyAST)) EmptyAST) (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "len") (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST)) EmptyAST) EmptyAST)),
            (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2019") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST) (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "number") EmptyAST EmptyAST) EmptyAST))),
            (ASTNode (ASTLetDatum "x") (ASTNode (ASTSimpleDatum "times") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "2019") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "cat") (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "CENG") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum "242") EmptyAST EmptyAST) EmptyAST))) (ASTNode (ASTSimpleDatum "plus") (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum "number") EmptyAST EmptyAST) EmptyAST) (ASTNode (ASTSimpleDatum "x") EmptyAST EmptyAST)))
            ]

funErrOut2 = [
             (ASTError "the value '1a' is not a number!"),
             (ASTError "times operation is not defined between str and num!"),
             (ASTError "times operation is not defined between str and str!"),
             (ASTError "cat operation is not defined between str and num!"),
             (ASTError "cat operation is not defined between num and num!"),
             (ASTError "len operation is not defined on num!"),
             (ASTError "negate operation is not defined on str!"),
             (ASTError "times operation is not defined between num and str!"),
             (ASTError "the value 'number' is not a number!")
             ]



test 1 = putStrLn $ "testing isNumber.."
         ++"\n"++  checker' (isNumOut, (map isNumber isNumIn), 0)

test 2 = putStrLn $ "testing eagerEvaluation.."
         ++"\n"++  checker'' (eagerEvalOut, (map eagerEvaluation eagerEvalIn), 0)
                     
test 3 = putStrLn $ "testing normalEvaluation.."
         ++"\n"++  checker'' (normalEvalOut, (map normalEvaluation normalEvalIn), 0)

test 29 = putStrLn $ "testing eagerEvaluation with erroneous inputs.."
          ++"\n"++  checker'' (funErrOut1, (map eagerEvaluation funErrIn1), 0)

test 39 = putStrLn $ "testing normalEvaluation with erroneous inputs.."
          ++"\n"++  checker'' (funErrOut2, (map normalEvaluation funErrIn2), 0)

test 0 = do
          test 1
          test 2
          test 3
          test 29
          test 39

test _ = help
