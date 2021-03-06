\begin{code}
{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

module BoolExpr where

class BoolExpr expr where
  trueB :: expr
  falseB :: expr
  andB :: expr -> expr -> expr
  orB :: expr -> expr -> expr
  notB :: expr -> expr
  impliesB :: expr -> expr -> expr
  xorB :: expr -> expr -> expr

ex1, ex2, ex3, ex4, ex5 :: BoolExpr expr => expr
ex1 = trueB
ex2 = notB trueB
ex3 = andB trueB falseB
ex4 = orB trueB falseB
ex5 = impliesB trueB falseB
\end{code}

\begin{code}
newtype Ir = Ir { value :: Int }

instance BoolExpr Ir where
  trueB = Ir { value = 1 }
  falseB = Ir { value = 0 }
  andB x y = if value x == 0 || value y == 0
    then Ir { value = 0 }
  else Ir { value = 1 }
  orB x y = if value x == 1 || value y == 1
    then Ir { value = 1 }
  else Ir { value = 0 }
  notB x = if value x == 0
    then Ir { value = 1 }
  else Ir { value = 0 }
  impliesB x y = if value x == 0 && value y == 1
    then Ir { value = 0 }
  else Ir { value = 1 }
  xorB x y = if value x == value y
    then Ir { value = 0 }
  else Ir { value = 1 }
\end{code}

\begin{code}
newtype Pr = Pr { tf :: Bool }

instance BoolExpr Pr where
  trueB = Pr { tf = True }
  falseB = Pr { tf = False }
  andB x y = if tf x == False || tf y == False
    then Pr { tf = False }
  else Pr { tf = True }
  orB x y = if tf x == True || tf y == True
    then Pr { tf = True }
  else Pr { tf = False }
  notB x = if tf x == False
    then Pr { tf = True }
  else Pr { tf = False }
  impliesB x y = if tf x == False && tf y == True
    then Pr { tf = False }
  else Pr { tf = True }
  xorB x y = if tf x == tf y
    then Ir { tf = False }
  else Ir { tf = True }
\end{code}

\begin{code}
newtype Qr = Qr { listtf :: [Bool] }

instance BoolExpr Qr where
  trueB = Qr { listtf = [True] }
  falseB = Qr { listtf = [False] }
  andB x y = Qr { listtf = listtf x ++ listtf y }
  orB x y = Qr { listtf = listtf x ++ listtf y }
  notB x = Qr { listtf = listtf x }
  impliesB x y = Qr { listtf = listtf x ++ listtf y }
  xorB x y = Qr { listtf = listtf x ++ listtf y }
\end{code}