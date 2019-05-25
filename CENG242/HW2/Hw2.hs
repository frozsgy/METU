module Hw2 where

data ASTResult = ASTError String | ASTJust (String, String, Int) deriving (Show, Read)
data ASTDatum = ASTSimpleDatum String | ASTLetDatum String deriving (Show, Read)
data AST = EmptyAST | ASTNode ASTDatum AST AST deriving (Show, Read)

isNumber :: String -> Bool
eagerEvaluation :: AST -> ASTResult
normalEvaluation :: AST -> ASTResult
-- DO NOT MODIFY OR DELETE THE LINES ABOVE -- 
-- IMPLEMENT isNumber, eagerEvaluation and normalEvaluation FUNCTIONS ACCORDING TO GIVEN SIGNATURES -- 

isDigit :: Char -> Bool
isNumberHelper :: String -> Bool
evaluate :: AST -> String
evaluateNum :: AST -> Int
evaluateSt :: AST -> String
isString :: AST -> Bool
isofNum :: AST -> Bool
replacer :: AST -> AST
isLet :: AST -> Bool
getReturnType :: AST -> String
countEager :: AST -> Int
countNormal :: AST -> Int
replacerNormal :: AST -> AST
isReplacable :: AST -> Bool
isSubString :: (String, String) -> Bool
hasError :: String -> Bool

isDigit x 
    | x == '0' = True
    | x == '1' = True
    | x == '2' = True
    | x == '3' = True
    | x == '4' = True
    | x == '5' = True
    | x == '6' = True
    | x == '7' = True
    | x == '8' = True
    | x == '9' = True
    | otherwise = False

isNumberHelper "" = False
isNumberHelper x = all isDigit x

isNumber "" = False
isNumber (x:xs)
    | x == '-' = isNumberHelper xs
    | otherwise = isNumberHelper (x:xs)

isString EmptyAST = False
isString (ASTNode (ASTSimpleDatum x) y z)
    | x == "str" = True
    | x == "cat" = isString y && isString z
    | otherwise = False
isString (ASTNode (ASTLetDatum x) y z) = isString y && isString z

isofNum EmptyAST = False
isofNum (ASTNode (ASTSimpleDatum x) y z) = case x of
    "str" -> False
    "cat" -> False
    "num" -> isofNum y
    "plus" -> ((isofNum y) && (isofNum z))
    "times" -> ((isofNum y) && (isofNum z))
    "negate" -> isofNum y
    "len" -> True
    x -> isNumber x
isofNum (ASTNode (ASTLetDatum x) y z) = (isofNum y) && (isofNum z)

isLet EmptyAST = False
isLet (ASTNode (ASTLetDatum x) y z) = True
isLet (ASTNode (ASTSimpleDatum x) y z) = (isLet y) || (isLet z)

isReplacable EmptyAST = False
isReplacable (ASTNode (ASTSimpleDatum q) _ _) = q /= "plus" && q /= "times" && q /= "cat" && q /= "len" && q /= "negate" && q /= "num" && q /= "str" 
isReplacable (ASTNode (ASTLetDatum _) _ _ ) = False

isSubString ("",_) = True
isSubString (_,"") = False
isSubString ((p:ps),(q:qs)) = if p == q
                              then isSubString (ps,qs)
                              else isSubString ((p:ps),qs)

hasError x = isSubString ("operation is not defined",x) || isSubString ("is not a number!",x)

evaluate EmptyAST = ""
evaluate (ASTNode d e f) = case d of
    ASTLetDatum t -> evaluate $ replacer (ASTNode d e f)
    ASTSimpleDatum "num" -> if (isofNum e) 
                            then show (evaluateNum e)
                            else "the value '"++(evaluate e)++"' is not a number!"
    ASTSimpleDatum "str" -> case e of
        (ASTNode (ASTSimpleDatum t) EmptyAST EmptyAST) -> t
    ASTSimpleDatum "plus" -> if ((isofNum e) && (isofNum f))
                             then show $ (evaluateNum $ replacer (ASTNode d e f))
                             else if isofNum e
                                  then if isString f && not (isLet f)
                                       then "plus operation is not defined between num and str!"
                                       else if isLet f
                                            then evaluate (ASTNode d e (replacer f))
                                            else evaluate f
                                  else if isString e && not (isLet e)
                                       then if isString f
                                            then "plus operation is not defined between str and str!"
                                            else "plus operation is not defined between str and num!"
                                       else if isLet e
                                            then evaluate (ASTNode d (replacer e) f)
                                            else evaluate e 
    ASTSimpleDatum "times" -> if ((isofNum e) && (isofNum f))
                              then show $ (evaluateNum $ replacer (ASTNode d e f))
                              else if isofNum e
                                   then if isString f && not (isLet f)
                                        then "times operation is not defined between num and str!"
                                        else if isLet f
                                             then evaluate (ASTNode d e (replacer f))
                                             else evaluate f
                                   else if isString e && not (isLet e)
                                        then if isString f
                                             then "times operation is not defined between str and str!"
                                             else "times operation is not defined between str and num!"
                                        else if isLet e
                                             then evaluate (ASTNode d (replacer e) f)
                                             else evaluate e
    ASTSimpleDatum "negate" -> if (isofNum e)
                               then show $ - evaluateNum e
                               else if (isString e)
                                    then "negate operation is not defined on str!"
                                    else evaluate e
    ASTSimpleDatum "len" -> if (isString e)
                            then show $ length (evaluate e)
                            else if (isofNum e)
                                 then "len operation is not defined on num!"
                                 else evaluate e
    ASTSimpleDatum "cat" -> if ((isString e) && (isString f))
                            then (evaluate e)++(evaluate f)
                            else if isofNum e
                                 then if isString f
                                      then "cat operation is not defined between num and str!"
                                      else "cat operation is not defined between num and num!"
                                 else "cat operation is not defined between str and num!"
    ASTSimpleDatum x -> x 

evaluateNum EmptyAST = 0
evaluateNum (ASTNode (ASTSimpleDatum e) f g) = case e of
            "num" -> evaluateNum(f)
            "plus" -> evaluateNum(f)+evaluateNum(g)
            "negate" -> (-evaluateNum(f))
            "times" -> (evaluateNum(f)*evaluateNum(g))
            "len" -> length (evaluateSt(f))
            z -> read z :: Int

evaluateSt EmptyAST = ""
evaluateSt (ASTNode (ASTSimpleDatum e) f g) = case e of
            "str" -> evaluateSt(f)
            "cat" -> evaluateSt(f)++evaluateSt(g)
            "len" -> show (length (evaluateSt(f)))
            "num" -> show (evaluateNum(f))
            "plus" -> show (evaluateNum(f)+evaluateNum(g))
            "negate" -> show(-evaluateNum(f))
            "times" -> show(evaluateNum(f)*evaluateNum(g))
            z -> z

replacer EmptyAST = EmptyAST
replacer (ASTNode (ASTSimpleDatum t) r s) = (ASTNode (ASTSimpleDatum t) (replacer r) (replacer s))
replacer (ASTNode (ASTLetDatum t) r s) = case s of
    (ASTNode (ASTSimpleDatum q) m n) ->  if q == t
        then if (isofNum r) 
             then (ASTNode (ASTSimpleDatum "num") (ASTNode (ASTSimpleDatum (evaluate r)) EmptyAST EmptyAST) EmptyAST)
             else if isReplacable r
                  then r
                  else (ASTNode (ASTSimpleDatum "str") (ASTNode (ASTSimpleDatum (evaluate r)) EmptyAST EmptyAST) EmptyAST)
        else if (q /= "plus" && q /= "times" && q /= "cat" && q /= "len" && q /= "negate") 
             then if isReplacable s
                  then s
                  else m
             else (ASTNode (ASTSimpleDatum q) (replacer (ASTNode (ASTLetDatum t) (ASTNode (ASTSimpleDatum (evaluate r)) EmptyAST EmptyAST) m)) (replacer (ASTNode (ASTLetDatum t) (ASTNode (ASTSimpleDatum (evaluate r)) EmptyAST EmptyAST) n)))
    (ASTNode (ASTLetDatum q) m n) -> replacer (ASTNode (ASTLetDatum q) (replacer m) (replacer n))

replacerNormal EmptyAST = EmptyAST
replacerNormal (ASTNode (ASTSimpleDatum t) r s) = (ASTNode (ASTSimpleDatum t) (replacerNormal r) (replacerNormal s))
replacerNormal (ASTNode (ASTLetDatum t) r s) = case s of
    (ASTNode (ASTSimpleDatum q) m n) ->  if q == t
        then r
        else if (q /= "plus" && q /= "times" && q /= "cat" && q /= "len" && q /= "negate") 
             then if isReplacable s
                  then s
                  else (ASTNode (ASTSimpleDatum q) m n)
             else replacerNormal (ASTNode (ASTSimpleDatum q) (replacerNormal (ASTNode (ASTLetDatum t) r m)) (replacerNormal (ASTNode (ASTLetDatum t) r n)))
    (ASTNode (ASTLetDatum q) m n) -> replacerNormal (ASTNode (ASTLetDatum t) r (replacerNormal s))
    EmptyAST -> EmptyAST

getReturnType EmptyAST = ""
getReturnType (ASTNode (ASTSimpleDatum q) _ _)
    | q == "plus" = "num"
    | q == "times" = "num"
    | q == "len" = "num"
    | q == "negate" = "num"
    | q == "num" = "num"
    | otherwise = "str"
getReturnType (ASTNode (ASTLetDatum q) p r) = getReturnType p

countEager EmptyAST = 0
countEager (ASTNode (ASTSimpleDatum p) q r)
    | p == "plus" = 1 + (countEager q) + (countEager r)
    | p == "times" = 1 + (countEager q) + (countEager r)
    | p == "len" = 1 + (countEager q) + (countEager r)
    | p == "negate" = 1 + (countEager q) + (countEager r)
    | p == "cat" = 1 + (countEager q) + (countEager r)
    | otherwise = (countEager q) + (countEager r)
countEager (ASTNode (ASTLetDatum p) q r) = (countEager q) + (countEager r)

countNormal EmptyAST = 0
countNormal x = countEager $replacerNormal x

eagerEvaluation x = if hasError $evaluate (replacerNormal x)
                    then ASTError $ evaluate (replacerNormal x)
                    else ASTJust (evaluate (replacerNormal x), getReturnType x, countEager x)
normalEvaluation x = if hasError $evaluate (replacerNormal x)
                     then ASTError $ evaluate (replacerNormal x)
                     else ASTJust (evaluate $ replacerNormal x, getReturnType x, countNormal x)