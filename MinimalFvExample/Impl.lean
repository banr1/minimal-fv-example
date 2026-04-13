namespace Demo

-- 具体実装: 末尾再帰
def revAux : List α → List α → List α
  | [],      acc => acc
  | x :: xs, acc => revAux xs (x :: acc)

def impl (xs : List α) : List α :=
  revAux xs []

end Demo
