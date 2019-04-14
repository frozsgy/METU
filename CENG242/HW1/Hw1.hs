module Hw1 where

type Mapping = [(String, String, String)]
data AST = EmptyAST | ASTNode String AST AST deriving (Show, Read)

writeExpression :: (AST, Mapping) -> String
evaluateAST :: (AST, Mapping) -> (AST, String)
-- DO NOT MODIFY OR DELETE THE LINES ABOVE -- 
-- IMPLEMENT writeExpression and evaluateAST FUNCTION ACCORDING TO GIVEN SIGNATURES -- 

writeMapping :: Mapping -> String
evaluateIt :: AST -> Int
evaluateSt :: AST -> String
replacer :: (AST, Mapping) -> AST

writeMapping [] = ""
writeMapping [(e,f,g)] 
    | f == "num" = e ++ "=" ++ g
    | f == "str" = e ++ "=\"" ++ g ++ "\""
writeMapping (a:ax) = case a of 
    (e, f, g) -> case f of
        "num" -> e ++ "=" ++ g ++ ";" ++ writeMapping(ax)
        "str" -> e ++ "=\"" ++ g ++ "\";" ++ writeMapping(ax) 

writeExpression (t,[m]) = "let " ++ writeMapping([m]) ++ " in " ++ writeExpression(t,[])
writeExpression (t,(m:n)) = "let " ++ writeMapping((m:n)) ++ " in " ++ writeExpression(t,[])
writeExpression (EmptyAST,_) = ""
writeExpression (t,[]) = 
    case t of 
        ASTNode e f g-> case e of
            "num" -> writeExpression(f,[])
            "plus" -> "(" ++ writeExpression(f,[]) ++ "+" ++ writeExpression(g,[]) ++ ")"
            "negate" -> "(-" ++ writeExpression(f,[]) ++ ")" ++ writeExpression(g,[])
            "times" -> "(" ++ writeExpression(f,[]) ++ "*" ++ writeExpression(g,[]) ++ ")"
            "str" -> "\"" ++ writeExpression(f,[]) ++ "\""
            "cat" -> case f of
                (ASTNode "str" _ _) -> "("  ++ writeExpression(f,[]) ++ "++" ++ writeExpression(g,[]) ++ ")"
                (ASTNode _ _ _) -> "("  ++ writeExpression(f,[]) ++ "++" ++ writeExpression(g,[]) ++ ")"
            "len" -> "(length " ++ writeExpression(f,[]) ++ writeExpression(g,[]) ++")"
            z -> z
        
replacer (ASTNode x EmptyAST EmptyAST,[(e,f,g)]) = 
    if e == x 
        then ASTNode f (ASTNode g EmptyAST EmptyAST) EmptyAST
        else ASTNode x EmptyAST EmptyAST
replacer (ASTNode x y z,[(e,f,g)]) = 
    if e == x 
        then ASTNode f (ASTNode g EmptyAST EmptyAST) EmptyAST
        else ASTNode x (replacer (y,[(e,f,g)])) (replacer (z,[(e,f,g)]))
replacer (EmptyAST, [(a)]) = EmptyAST
replacer (t,(a:ax)) = replacer ((replacer (t,[(a)]), (ax)))

evaluateAST (EmptyAST,[]) = (EmptyAST, [])
evaluateAST (t,[]) = (t,evaluateSt(t))
evaluateAST (t,[(e,f,g)]) = 
    case f of
        "num" -> (replacer (t,[(e,f,g)]), evaluateSt(replacer (t,[(e,f,g)])))
        "str" -> (replacer (t,[(e,f,g)]), evaluateSt(replacer (t,[(e,f,g)])))
evaluateAST (t,(a:ax)) = (replacer ((replacer (t,[(a)]), (ax))), evaluateSt(replacer ((replacer (t,[(a)]), (ax)))))

evaluateIt t = 
    case t of
        ASTNode e f g -> case e of
            "num" -> evaluateIt(f)
            "plus" -> evaluateIt(f)+evaluateIt(g)
            "negate" -> (-evaluateIt(f))
            "times" -> (evaluateIt(f)*evaluateIt(g))
            "len" -> length (evaluateSt(f))
            z -> read z :: Int

evaluateSt t =
    case t of 
        ASTNode e f g -> case e of
            "str" -> evaluateSt(f)
            "cat" -> evaluateSt(f)++evaluateSt(g)
            "len" -> show (length (evaluateSt(f)))
            "num" -> show (evaluateIt(f))
            "plus" -> show (evaluateIt(f)+evaluateIt(g))
            "negate" -> show(-evaluateIt(f))
            "times" -> show(evaluateIt(f)*evaluateIt(g))
            z -> z